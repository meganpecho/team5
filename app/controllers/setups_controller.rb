class SetupsController < ApplicationController
  include SetupsHelper
  before_action :is_setup

  # GET /setup/start
  def start
    @courses = getCourses().to_json
  end
  
  # POST /setup/start
  def addclasses
    values = []
    params.each do |key, value|
      if key[0,5] == "class"
        values.push(value.to_i)
      end
    end
    current_user.update_attributes(course_ids: values.to_s, setup: true)
    if current_user.errors.empty?
      flash[:success] = "Courses saved successfully."
    else
      current_user.errors.each do |error|
        flash[:error] = error
      end
    end
    redirect_to '/account'
  end
  private
  
  def is_setup
    unless logged_in?
      flash[:error] = "You must be logged in."
      redirect_to login_url
    end
    if current_user.is_setup?
    #   flash[:warning] = "Your account is already setup."
    #   redirect_to '/account'
    end
  end
end
