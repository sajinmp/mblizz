require 'spec_helper'

describe "Users" do

  subject { page }

  describe "index page" do

    before(:each) do
      sign_in FactoryGirl.create(:user)
      visit users_path
    end

    it { should have_title("Member list") }
    it { should have_content("All users") }

    describe "pagination" do

      before(:all)  { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do

        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end

      end

    end

    describe "delete links" do

      it { should_not have_link('Delete') }

      describe "as admin user" do

        let(:admin) { FactoryGirl.create(:admin) }

        before do
          sign_in admin
          visit users_path
        end
        
        it { should have_link('Delete', href: user_path(User.first)) }

        it "should be able to delete user" do

          expect do
            click_link('Delete', match: :first)
          end.to change(User, :count).by(-1)

        end
        
        it { should_not have_link('Delete', href: users_path(admin)) }

      end

    end

  end

  describe "sign up page" do
  
    before  { visit signup_path }

    it { should have_title('Sign Up') }

  end

  describe "profile page" do
  
    let(:user)  { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before  { visit user_path(user) }

    it { should have_title(user.name) }
    it { should have_content(user.name) }

    describe "follow/unfollow buttons" do

      let(:other_user) { FactoryGirl.create(:user) }
      before  { sign_in user }

      describe "following a user" do

        before  { visit user_path(other_user) }

        it "should increment followed user count" do

          expect { click_button "Follow" }.to change(user.followed_users, :count).by(1)

        end

        it "should increment followers count" do

          expect { click_button "Follow" }.to change(other_user.followers, :count).by(1)

        end

        describe "toggling button" do

          before  { click_button "Follow" }

          it { should have_xpath("//input[@value='Unfollow']") }

        end

      end

      describe "unfollowing a user" do

        before do
          visit user_path(other_user)
          click_button "Follow"
        end

        it "should decrement followed user count" do

          expect { click_button "Unfollow" }.to change(user.followed_users, :count).by(-1)

        end

        it "should decrement followers count" do

          expect { click_button "Unfollow" }.to change(other_user.followers, :count).by(-1)
        
        end

        describe "toggling button" do

          before  { click_button "Unfollow" }

          it { should have_xpath("//input[@value='Follow']") }

        end

      end

    end

    describe "microposts" do

      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }

    end

  end


  describe "Sign Up" do
  
    before  { visit signup_path }

    let(:submit) { "Create account" }

    describe "with invalid info" do

      it "should not create a user" do

        expect { click_button submit }.not_to change(User, :count)

      end

      describe "after submission" do

        before  { click_button submit }

        it { should have_content('error') }

      end

    end

    describe "with valid info" do
  
      before do

        fill_in "Name", with: "Example User"
        fill_in "Username", with: "example"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Password confirmation", with: "foobar"
        choose('Male')
        fill_in "City", with: "Thrissur"
        fill_in "State", with: "Kerala"
        fill_in "Country", with: "India"
        fill_in "Zip code", with: "680308"
        fill_in "Phone number", with: "9745165109"

      end

      it "should create a user" do

        expect { click_button submit }.to change(User, :count).by(1)

      end

      describe "after saving user" do
        
        before  { click_button submit }
        let(:user)  { User.find_by(email: "user@example.com") }
        
        it { should have_link("Sign out") }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success') }

      end

    end

  end

  describe "edit" do

    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
      visit edit_user_path(user)
    end

    describe "page" do

      it { should have_content("Update your profile") }
      it { should have_title("Edit profile") }
      it { should have_link("Change", href: "http://gravatar.com/emails") }

    end

    describe "with invalid info" do

      before  { click_button "Update changes" }

      it { should have_content("error") }

    end

    describe "with valid info" do
      
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do

        fill_in "Name", with: new_name
        fill_in "Username", with: user.username
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password
        choose('Male')
        fill_in "City", with: user.city
        fill_in "State", with: user.state
        fill_in "Country", with: user.country
        fill_in "Zip code", with: user.zip
        fill_in "Phone number", with: user.phno
        click_button "Update changes"

      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
          
    end

    describe "forbidden attribs" do

      let(:params) do
        { user: { admin: true, password: user.password, password_confirmation: user.password} }
      end

      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end

      specify { expect(user.reload).not_to be_admin }

    end

  end

  describe "following/followers" do

    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before  { user.follow!(other_user) }

    describe "followed users" do

      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_title('Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }

    end

    describe "followers" do

      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_title('Followers') }
      it { should have_link(user.name, href: user_path(user))}

    end

  end

end
