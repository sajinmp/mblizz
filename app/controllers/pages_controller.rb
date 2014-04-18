class PagesController < ApplicationController
  def home

    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end

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
