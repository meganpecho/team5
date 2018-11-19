module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
  
  def is_admin?
    if logged_in?
        (current_user.clearance > 2)
    else
        false
    end
  end
  
  def is_fac?
    if logged_in?
        (current_user.clearance > 1)
    else
        false
    end
  end
  
  def is_user?
      if logged_in?
        (current_user.clearance > 0)
      else
        false
      end
  end
  
  def must_be_logged
    unless logged_in?
      flash[:error] = "You are not logged in."
      redirect_to login_url
    end
    unless current_user.is_setup?
      flash[:warning] = "You need to setup your account. Please import the courses you have taken."
      redirect_to '/courses/add'
    end
  end
  
  def must_be_faculty
    unless is_fac?
      flash[:error] = "You are not logged in as faculty."
      redirect_to root_url
    end
  end
  
  def must_be_admin
    unless is_admin?
      flash[:error] = "You are not logged in as admin."
      redirect_to root_url
    end
  end
  
end
