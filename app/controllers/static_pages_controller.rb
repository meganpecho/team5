class StaticPagesController < ApplicationController
    def home
        #flash[:error] = "Test"
        if logged_in?
            redirect_to '/account'
        end
    end
    
    def testing
        if(params[:query])
            @query = params[:query]
            @response = search(@query)
        else
            @query = "Cached dev query for \"JavaScript\""
            @response = DevJobs
        end
        puts @response.class
    end
    
    def faq
        
    end
    
    def about
        
    end

    def contact
        
    end
end
