class SkillAssessmentsController < ApplicationController
  include SkillAssessmentsHelper
  def skill_assessment
  end
  
  def job_match
    @courses_taken = current_user.courses
  end
  
  def results
    logger.debug(params[:title])
    
    
    job_search = JobSearch.new(search_type: 1, search_results: nil, ready: false, user_id: current_user.id, title: params[:title] == "" ? "Job Search #{JobSearch.where(:user_id => current_user.id).count(:id) + 1}" : params[:title])
    
    job_search.save
    
    JobSearchJob.perform_async(params[:skills], job_search.id, current_user.id)
    
    render js: "window.location.replace(\"/searches/#{job_search.id}\");"
    
    
    #thread = Thread.new {
    #  runJobSearch(params, job_search) 
    #  ActiveRecord::Base.connection.close
    #}
    #thread.join
  end
  
end
