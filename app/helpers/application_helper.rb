module ApplicationHelper
    require "base64"
    require "json"
    require "uri"
    require "cgi"
    
    def formatAllCourses()
        courses = Course.all.select(:title, :id, :subject, :course_num).order(:subject, :course_num)
        results = []
        courses.each do |course|
          results.push({
            class_num: course.course_num.to_s,
            class_name: course.title,
            class_type: course.subject,
            class_id: course.id.to_s,
            search_help: "#{course.subject} #{course.course_num}"
          })
        end
        return results
    end
    
    def formatUserCourses(courses)
        results = {}
        courses.each do |course|
            results[course.id] = {
                class_num: course.course_num.to_s,
                class_name: course.title,
                class_type: course.subject,
                class_id: course.id.to_s,
                search_help: "#{course.subject} #{course.course_num}"
            }
        end
        return results
    end
    
    def job_search(query, perpage = 10, location = nil)
        logger.debug(query)
        logger.debug(CGI.unescape(query))
        base_url = "https://authenticjobs.com/api/"
        method = "aj.jobs.search"
        if location.nil?
            api_params = URI.encode_www_form(:api_key => ENV['AUTHENTIC_KEY'], :method => method, :format => "json", :type => 1, :perpage => perpage)
        else
            api_params = URI.encode_www_form(:api_key => ENV['AUTHENTIC_KEY'], :method => method, :format => "json", :type => 1, :perpage => perpage, :location => location)
        end
        
        uri = URI(base_url)
        uri.query = api_params + "&keywords=#{query}"
        
        puts uri.to_s
        
        res = Net::HTTP.get_response(uri)
        
        #puts res.body
        listings = JSON.parse(res.body)
        logger.info(listings)
        if !listings["listings"].nil? && !listings["listings"]["listing"].nil?
            logger.debug(listings["listings"]["listing"])
            return listings["listings"]["listing"]
        else
            return []
        end
    end
    
    
    
    
    
    
    def getToken()
        
        uri = URI("https://www.googleapis.com/oauth2/v4/token")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.set_debug_output($stdout)
        req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/x-www-form-urlencoded'})
        
        expire_time = 1.hour.from_now.to_i

        
        file = File.read ENV['GOOGLE_APPLICATION_CREDENTIALS']
        data = JSON.parse(file)
        
        header = Base64.urlsafe_encode64('{"alg":"RS256","typ":"JWT"}'.encode('utf-8'))
        
        bodyobj = {
          iss: data['client_email'],
          scope: "https://www.googleapis.com/auth/jobs",
          aud: "https://www.googleapis.com/oauth2/v4/token",
          exp: expire_time,
          iat: Time.now.to_i
        }.to_json
        
        #puts bodyobj
        
        body = Base64.urlsafe_encode64(bodyobj.encode("utf-8")).tr!("=\n","")
        
        rsa_private = OpenSSL::PKey::RSA.new(data['private_key'])
        
        sig = Base64.urlsafe_encode64(JWT::Signature.sign('RS256', "#{header}.#{body}", rsa_private))
        
        puts sig
        
        complete = "#{header}.#{body}.#{sig}"
        
        #puts "Decoded: "
        
        #JWT.decode(complete, rsa_private,  true, { algorithm: 'RS256' }).each do |array|
        #    if array.class == String
        #        puts Base64.urlsafe_decode64(array)
        #    else
        #        puts array
        #    end
        #end
        
       
        req.body = URI.encode_www_form(:assertion => complete, :grant_type => "urn:ietf:params:oauth:grant-type:jwt-bearer")
        
        res = http.request(req)
        
        res_hash = JSON.parse(res.body)
        
        puts res.body
        #puts res_hash
        #puts res_hash['access_token']
        
        if res_hash['access_token'] != nil
            ENV['GOOGLE_API_TOKEN'] = res_hash['access_token']
            ENV['GOOGLE_API_EXP'] = expire_time.to_s
            puts "TOKEN: #{ENV['GOOGLE_API_TOKEN']}"
            puts "EXP: #{ENV['GOOGLE_API_EXP']}"
        else
            ENV['GOOGLE_API_TOKEN'] = nil
            ENV['GOOGLE_API_EXP'] = nil
        end
        
        
    end
    
    
    
    def jobSearch()
        if ENV['GOOGLE_API_TOKEN'].nil? || ENV['GOOGLE_API_EXP'].to_i <= Time.now.to_i
            getToken()
        end
        #puts ENV['GOOGLE_API_TOKEN']
        key = ENV['GOOGLE_API_TOKEN']
        base_url = "https://jobs.googleapis.com/v3/projects/skillmatic-218900/jobs:search"
        #puts base_url
        apirequest = {
            "searchMode" => "JOB_SEARCH",
            "jobView" => "JOB_VIEW_FULL",
            "jobQuery" => {
                "query" => "Ruby on Rails Developer",
                "jobCategories" => [ "COMPUTER_AND_IT" ],
                "employmentTypes" => [ "FULL_TIME" ],
                "languageCodes" => [ "en" ]
            },
            "requestMetadata" => {
              "domain" => "console.aws.amazon.com",
              "sessionId" => "100",
              "userId" => "200"
            }
        }.to_json
        
        
        
        uri = URI(base_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.set_debug_output($stdout)
        req = Net::HTTP::Post.new(uri.path, {"Authorization" => "Bearer #{key}", "Content-Type" =>"application/json"})
        req.body = apirequest
        res = http.request(req)
        
        puts res.body
        
        
        
        
    end

    
    
end
