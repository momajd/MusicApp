class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #SHOULD I KEEP THIS???
  #protect_from_forgery with: :exception

  def current_user
    return nil if session[:user_id].nil?
    @current_user ||= User.find(session[:user_id]) #Verify use of intant var
  end

  def log_in!(user)
    session[:user_id] = user.id
  end

  def log_out!
    session[:user_id] = nil
  end
end
