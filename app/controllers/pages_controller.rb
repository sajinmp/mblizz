class PagesController < ApplicationController
  def home
    @title = "MBlizz"
  end

  def help
    @title = "Help"
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact Us"
  end

  def terms
    @title = "Terms & Conditions"
  end

  def privacy
    @title = "Privacy Policy"
  end

  def team
    @title = "Team"
  end
end
