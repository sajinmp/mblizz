class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
  
    @user = User.new

  end
  
  def show
    
    @user = User.find(params[:id])

  end

  def create
    
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to MBlizz"
      redirect_to @user
    else
      render 'new'
    end

  end

  def edit
  end

  def update

    if @user.update_attributes(user_params)
      flash[:success] = "Profile is updated"
      redirect_to @user
    else
      render 'edit'
    end

  end

 private


  def user_params
  
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :dob,
                                 :sex, :city, :state, :country, :zip, :phno)


  end

  def signed_in_user

    redirect_to signin_url, notice: "Please sign in to continue" unless signed_in?

  end

  def correct_user
  
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)

  end

end
