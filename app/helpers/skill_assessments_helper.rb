module SkillAssessmentsHelper
    
    def skills_frequency(courses, skills_e = nil)
        skills = {}
        Skill.all.each do |skill|
            skills[skill.id] = 0
        end
        if skills_e
            skills_e.each { |skill| skills[skill.to_i] = skills[skill.to_i] + 1 }
        end
        courses.each do |course|
            course.skills.each do |skill|
                skills[skill.id] = skills[skill.id] + 1
            end
        end
        return skills
    end
    
    def runJobSearch(params, job_search)
        courses = current_user.courses
        if params[:skills].nil? || params[:skills].empty?
          @skills_f = skills_frequency(courses)
        else
          @skills_f = skills_frequency(courses, params[:skills])
        end
        total = 0
        @skills_f.each do |key, val|
          total = total + val.to_i
        end
        total = total + 0.0
        @results_num = 20
        @results_f = {}
        @skills_f.each do |key, val|
          if val.to_i > 0
            #logger.debug("Key: " + key.to_s)
            #logger.debug("Val: " + val.to_s)
    
            val_tot = val/total
            
            logger.debug(val_tot)
          
            @results_f[key] = (val_tot * @results_num).round
            #logger.debug(@results_f[key])
          end
        end
        #logger.debug(@skills_f)
        #logger.debug(@results_f)
        
        job_array = []
        @jobs = []
        
        @results_f.each do |key, val|
          results = job_search(Skill.find(key).name, val)
          results.each do |result|
            job = JobObject.new(
              listing_id: result["id"],
              title: result["title"],
              description: result["description"],
              apply_text: result["howto_apply"],
              apply_url: result["apply_url"],
              post_date: result["post_date"],
              relocation_assistance: result["relocation_assistance"].to_i == 1 ? true : false,
              telecommuting: result["telecommuting"].to_i == 1 ? true : false,
              category: result["category"]["name"],
              keywords: result["keywords"],
              job_type: result["type"].nil? ? "Unknown" : result["type"]["name"],
              company_name: result["company"].nil? ? "" : result["company"]["name"],
              company_url: result["company"].nil? ? "" : result["company"]["url"],
              company_logo: result["company"].nil? ? "" : result["company"]["logo"],
              company_tagline: result["company"].nil? ? "" : result["company"]["tagline"],
              company_location: result["company"].nil? ? "Unknown Location" : result["company"]["location"].nil? ? "Unknown Location" : result["company"]["location"]["name"],
              job_url: result["url"],
              perks: result["perks"].nil? ? "Unknown" : result["perks"]
            )
            if JobObject.where("listing_id = ?", job.listing_id).empty?
              if job.save
                job_array.push(job.id)
              end
            else
              job = JobObject.where("listing_id = ?", job.listing_id)[0]
              job_array.push(job.id)
            end
          end
        end
        if job_search.update_attributes(search_results: job_array.to_json, ready: true)
            return true
        else
            return false
        end
    end
end
