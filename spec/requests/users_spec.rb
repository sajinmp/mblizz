require 'spec_helper'

describe "Users" do

  subject { page }
  
  describe "sign up page" do
  
    before  { visit signup_path }

    it { should have_title('Sign Up') }

  end

  describe "profile page" do
  
    let(:user)  { FactoryGirl.create(:user) }
    before  { visit user_path(user) }

    it { should have_title(user.name) }
    it { should have_content(user.name) }

  end

end
