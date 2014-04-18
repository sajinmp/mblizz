class MicropostsController < ApplicationController

  before_action :signed_in_user

  def create
  
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created successfully"
      redirect_to root_url
    else
      @feed_items = []
      render 'pages/home'
    end
  
  end

  def destroy
  end

 private

  def micropost_params

    params.require(:micropost).permit(:content)

  end

end
