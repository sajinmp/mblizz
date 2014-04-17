class PagesController < ApplicationController
  def home
  
    @micropost = current_user.microposts.build if signed_in?
  
  end

  def help
  end

  def about
  end

  def contact
  end

  def terms
  end

  def privacy
  end

  def team
  end
end
