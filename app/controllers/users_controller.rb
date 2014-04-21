class UsersController < ApplicationController

  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  

  def new

    question = { 1 => "Which is the third alphabet in 'MBlizz'?", 
                 2 => "Which is third planet from the sun?",
                 3 => "How many alphabets are there in 'MBlizz'?",
                 4 => "What is 3 + 4 ?" }
    $random_number = rand(1..4)
    @displayed = question[$random_number]
    @user = User.new

  end

  def index

    @users = User.paginate(page: params[:page])

  end

  def show
    
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

  end

  def create
  
    question = { 1 => "Which is the third alphabet in 'MBlizz'?",
                 2 => "Which is third planet from the sun?",
                 3 => "How many alphabets are there in 'MBlizz'?",
                 4 => "What is 3 + 4 ?" }
    @displayed = question[$random_number]
    answer = { 1 => ['l', 'L'],
               2 => ['earth', 'Earth', 'EARTH'],
               3 => ['6', 'six', 'Six', 'SIX'],
               4 => ['7', 'seven', 'Seven', 'SEVEN'] }
    @user = User.new(user_params)
    if answer[$random_number].include?(params[:random_q])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to MBlizz"
        redirect_to @user
      else
        render 'new'
      end
    else
      flash[:danger] = "Oops, Wrong answer to random question"
      redirect_to signup_path
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

  def destroy

    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url

  end

  def following

    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'

  end

  def followers

    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'

  end

 private

  def user_params
  
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :dob,
                                 :sex, :city, :state, :country, :zip, :phno)


  end

  def correct_user
  
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)

  end

  def admin_user

    redirect_to(root_url) unless current_user.admin?

  end

end
