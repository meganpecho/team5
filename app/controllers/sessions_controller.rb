class SessionsController < ApplicationController
  def login
    if logged_in?
      redirect_to root_url
    end
    
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    respond_to do |format|
      if user && user.authenticate(params[:password])
        log_in user
        flash[:success] = "Successfully logged in"
        if current_user.clearance > 1
          format.js { @redirect = '/dashboard' }
        else
          format.js { @redirect = '/account' }
        end
      else
        format.js { @error = 'Invalid email/password combination' }
        #format.html { render 'login' }
      end
    end
  end
  
  def destroy
    log_out
    flash[:success] = "Successfully logged out"
    redirect_to root_url
  end
end
