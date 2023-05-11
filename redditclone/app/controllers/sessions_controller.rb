class SessionsController < ApplicationController
  before_action :required_logged_in, only: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    username =params[:user][:username]
    password =params[:user][:password]
    @user = User.find_by_credentials(username, password)
    if @user
      login!(@user)
      redirect_to users_url
    else
      @user = User.new(username: username)
      flash.now[:message] = ["invalid username or pasword"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url 
  end
end
