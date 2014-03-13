require 'spec_helper'

describe "Users" do
  
  describe "sign up page" do
    
    it "should have the title 'Sign Up" do
      
      visit signup_path
      expect(page).to have_title('Sign Up')
    
    end
  
  end

end
