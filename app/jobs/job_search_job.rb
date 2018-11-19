class JobSearchJob
  include Sidekiq::Worker
  include ApplicationHelper
  include SkillAssessmentsHelper

  def perform(skills, job_search_id, current_user_id)
    job_search = JobSearch.find(job_search_id)
    current_user = User.find(current_user_id)
    courses = current_user.courses
    if skills.nil? || skills.empty?
      @skills_f = skills_frequency(courses)
    else
      @skills_f = skills_frequency(courses, skills)
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
      if results
        logger.info(results)
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
          logger.info(job.listing_id)
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
    end
    logger.debug(job_array)
    logger.info(job_array)
    job_search.update_attributes(search_results: job_array.to_json, ready: true)
  end
end
