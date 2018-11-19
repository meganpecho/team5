class DashboardController < ApplicationController
    before_action :must_be_faculty
    
    def main
        @user = User.where(:clearance => 1)
    end
    
    def students
        
    end
    
    def users_csv
      respond_to do |format|
        format.csv { send_data(User.where(:clearance => 1).to_csv, :filename => "users.csv") }
      end
    end
    
    def user_csv
      @user = User.find(params[:user_id])
      respond_to do |format|
        format.html
        format.csv { send_data(@user.to_csv, :filename => "user-#{@user.id}.csv") }
      end
    end
    
    def courses_csv
      respond_to do |format|
        format.html
        format.csv { send_data(Course.all.to_csv, :filename => "courses.csv") }
      end
    end
    
    def skills_csv
      respond_to do |format|
        format.html
        format.csv { send_data(CourseSkill.all.to_csv, :filename => "CourseSkill.csv") }
      end
    end
end