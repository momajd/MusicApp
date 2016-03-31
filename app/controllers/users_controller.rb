class UsersController < ApplicationController

  before_action :ensure_current_user, only: [:show]

  def new
    @user = User.new #dummy user to catch errors
    #show new user page
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in!(@user)
      redirect_to user_url
    else
      render :new
    end
  end

  def show
    #need to check for log in first; add current user
    @user = current_user
    render :show
  end

  private
  def user_params
    self.params.require(:user).permit(:email, :password, :session_token)
  end

  def ensure_current_user
    redirect_to new_session_url if current_user.nil?
  end

end
