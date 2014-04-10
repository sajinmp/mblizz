require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "sign-in page" do

    before  { visit signin_path }

    it { should have_content("Sign in") }
    it { should have_title("MBlizz") }

    describe "with invalid info" do
      
      before  { click_button "Sign in" }

      it { should have_title("MBlizz") }
      it { should have_selector('div.alert.alert-danger') }
    
      describe "after visiting another page" do

        before  { click_link "Home" }

        it { should_not have_selector('div.alert.aler-error') }

      end

    end

    describe "with valid info" do
      
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should have_link('Users', href: users_path) }

      describe "after signing out" do

        before  { click_link "Sign out" }

        it { should_not have_link("Sign out") }
        it { should have_link("Sign in") }

      end

    end

  end

  describe "authorization" do

    describe "for not signed-in users" do

      let(:user) { FactoryGirl.create(:user) }

      describe "when visiting a protected page" do

        before do
          visit edit_user_path(user)
          fill_in "Username", with: user.username
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        
        describe "after signing in" do

          it "should render the protected page" do

            expect(page).to have_title('Edit profile')

          end
          
          describe "when signing in again" do

            before do
              click_link "Sign out"
              visit signin_path
              fill_in "Username", with: user.username
              fill_in "Password", with: user.password
              click_button "Sign in"
            end

            it "should render the profile page" do

              expect(page).to have_title(user.name)

            end

          end

        end

      end

      describe "in the users controller" do

        describe "visiting the edit page" do

          before  { visit edit_user_path(user) }

          it { should have_title("MBlizz") }

        end
        
        describe "submitting the update action" do

          before { patch user_path(user) }

          specify { expect(response).to redirect_to(signin_path) }

        end

        describe "visiting user index page" do

          before  { visit users_path }

          it { should have_title('MBlizz') }
          it { should have_content('Sign in') }

        end

      end

    end

    describe "as wrong user" do

      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, username: "wrong", email: "wrong@example.com") }
      before  { sign_in user, no_capybara: true }

      describe "trying to access user edit page" do

        before  { get edit_user_path(wrong_user) }

        specify { expect(response.body).not_to match('Edit profile') }
        specify { expect(response).to redirect_to(root_url) }

      end
      
      describe "trying to update user data" do

        before  { patch user_path(wrong_user) }

        specify { expect(response).to redirect_to(root_url) }

      end

    end

    describe "as non admin" do

      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before  { sign_in non_admin, no_capybara: true }

      describe "submitting a delete request" do

        before  { delete user_path(user) }

        specify { expect(response).to redirect_to(root_url) }

      end

    end

  end

end
