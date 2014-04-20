require 'spec_helper'

describe "Pages" do

  subject { page }

  describe "Home page" do

    it "should have the title 'MBlizz'" do
      
      visit root_path 
      expect(page).to have_title("MBlizz")
    
    end

    describe "for signed in user" do

      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render user feed" do

        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end

      end

      describe "follower/following count" do

        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit user_path(user)
        end

        it { should have_link('0 Following', href: following_user_path(user)) }
        it { should have_link('1 Followers', href: followers_user_path(user)) }

      end

    end

  end


  describe "Help" do

    it "should have the title 'Help'" do

      visit help_path
      expect(page).to have_title("Help")

    end

  end
  
  describe "About page" do
    
    it "should have the title 'About'" do
      
      visit about_path
      expect(page).to have_title("About")
    
    end
  
  end


  describe "Contact page" do
    
    it "should have the title 'Contact us'" do
      
      visit contact_path
      expect(page).to have_title("Contact Us")
    
    end
  
  end


  describe "Terms page" do
    
    it "should have the title 'Terms & Conditions'" do
      
      visit terms_path
      expect(page).to have_title("Terms & Conditions")
    
    end
 
  end


  describe "Privacy page" do
    
    it "should have the title 'Privacy Policy'" do
      
      visit privacy_path
      expect(page).to have_title("Privacy Policy")
    
    end
  
  end


  describe "Team page" do
    
    it "should have the title 'Team'" do
      
      visit team_path
      expect(page).to have_title("Team")
    
    end
  
  end

end
