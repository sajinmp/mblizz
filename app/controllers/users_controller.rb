class UsersController < ApplicationController


  def new
  
    @title = 'Sign Up'
    @user = User.new

  end
  
  def show
    
    @user = User.find(params[:id])
    @title = @user.name

  end

  def create
    
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to MBlizz"
      redirect_to @user
    else
      render 'new'
    end

  end


 private


  def user_params
  
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :dob,
                                 :sex, :city, :state, :country, :zip, :phno)


  end


end
