class SessionsController < ApplicationController

  def new
    @title = "MBlizz"
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:danger] = "Username or password is not correct"
      render 'new'
    end
  end

  def destroy
  end

end
