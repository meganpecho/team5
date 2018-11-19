class SearchesController < ApplicationController
  def results
    @search = JobSearch.where(:id => params[:id])[0]
    if @search.nil?
      flash[:error] = "Search not found"
      redirect_back(fallback_location: root_url)
    end
    
    if current_user.id != @search.user_id
      flash[:error] = "This is not your search"
      redirect_back(fallback_location: root_url)
    end
    
    if @search.search_results
      @jobs = []
      JSON.parse(@search.search_results).each do |id|
        job = JobObject.where(:id => id)[0]
        if job
          @jobs.push(job)
        end
      end
    end
  end
  
  def ready
    if JobSearch.find(params[:id]).ready 
      render js: "location.reload()"
    end
  end
end
