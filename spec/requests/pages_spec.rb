require 'spec_helper'

describe "Pages" do
  
  describe "Home page" do

    it "should have the title 'MBlizz'" do
      
      visit root_path 
      expect(page).to have_title("MBlizz")
    
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
