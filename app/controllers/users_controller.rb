class UsersController < ApplicationController
  before_action :must_be_logged, only: [:account]

  # GET /account
  def account
    @user = current_user
    @searches = JobSearch.where(:user_id => current_user.id)
    @searches_desc = @searches.order(id: :desc)
  end
  
  # GET /signup
  def new
    if logged_in?
      redirect_to '/account'
    end
    results = { results: [], paginate: { more: true } }
      
    cs = {
      text: "CS",
      children: []
    }
    is = {
      text: "IS",
      children: []
    }
    Major.all.each do |major|
      formatted = {
        id: major.id,
        text: major.full_title
      }
      if major.subject == "CS"
        cs[:children].push(formatted)
      else
        is[:children].push(formatted)
      end
    end
    results[:results].push(cs)
    results[:results].push(is)
    @majors = results.to_json
    
    @user = User.new
    
  end

  # POST /signup
  def create
    @user = User.new(user_params.merge(clearance: 1, course_ids: nil, setup: false))
    respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = "Account created. Please import the courses you have taken."
        logger.debug("Test")
        format.js { @redirect = '/courses/add' }
      else
        logger.debug(@user.errors.full_messages)
        #@errors = @user.errors.full_messages
        format.js { @errors = @user.errors.full_messages }
        #format.html { render :new }
      end
    end
  end

  # POST /account
  def update
    #if params[:user][:password]
    #make sure authentication works
    #else
    #don't update password or password_confirmation
    @user = current_user
    respond_to do |format|
      if params[:user][:password].nil?
        if @user.update_attributes(:name => params[:user][:name], :major_id => params[:user][:major_id])
          flash[:success] = "Account updated."
          format.js { @redirect = '/account/' }
        else
          format.js { @errors = @user.errors.full_messages }
        end
      else
        if @user.update(:name => params[:user][:name], :major_id => params[:user][:major_id], :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
          flash[:success] = "Account updated."
          format.js { @redirect = '/account/' }
        else
          format.js { @errors = @user.errors.full_messages }
        end
      end
    end
  end

  # GET /addcourses
  def add_courses
    if current_user.is_setup?
      @courses = []
      courses = formatAllCourses()
      @u_courses = formatUserCourses(current_user.courses)
      u_courses = JSON.parse(current_user.course_ids)
      logger.debug(u_courses)
      courses.each do |course|
        if !u_courses.include? course[:class_id].to_i
          @courses.push(course)
        end
      end
      @courses = @courses.to_json
    else
      @u_courses = {}
      @courses = formatAllCourses().to_json
    end
    
  end
  
  # POST /addcourses
  def save_courses
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

  def mod_user
    @user = current_user
    
    results = { results: [], paginate: { more: true } }
    cs = {
      text: "CS",
      children: []
    }
    is = {
      text: "IS",
      children: []
    }
    Major.all.each do |major|
      formatted = {
        id: major.id,
        text: major.full_title
      }
      if major.id == current_user.major_id
        formatted[:selected] = true
      end
      if major.subject == "CS"
        cs[:children].push(formatted)
      else
        is[:children].push(formatted)
      end
    end
    results[:results].push(cs)
    results[:results].push(is)
    @majors = results.to_json
  end
  
  def csv_maker
    @users = User.all
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end
  
  def my_results
@results = Result.where(user_id: current_user.id)
  respond_to do |format|
  format.html
  format.csv { send_data @results.to_csv }
  end
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |result|
        csv << result.attributes.values_at(Name Major Email Corses Taken)
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
  

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :major_id)
    end
end
