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


  describe "Sign Up" do
  
    before  { visit signup_path }

    let(:submit) { "Create account" }

    describe "with invalid info" do

      it "should not create a user" do

        expect { click_button submit }.not_to change(User, :count)

      end

    end

    describe "with valid info" do
  
      before do

        fill_in "Name", with: "Example User"
        fill_in "Username", with: "example"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Password confirmation", with: "foobar"
        fill_in "City", with: "Thrissur"
        fill_in "State", with: "Kerala"
        fill_in "Country", with: "India"
        fill_in "Zip code", with: "680308"
        fill_in "Phone number", with: "9745165109"

      end

      it "should create a user" do

        expect { click_button submit }.to change(User, :count).by(1)

      end

    end

  end

end
