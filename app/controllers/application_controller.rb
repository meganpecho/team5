class ApplicationController < ActionController::Base
  require 'net/http'
  include SessionsHelper
  include ApplicationHelper
  protect_from_forgery with: :exception
  
end
