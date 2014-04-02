require 'spec_helper'

describe User do

  before  { @user = User.new(name: "Example User", username: "example", email: "user@example.com", 
            password: "foobar", password_confirmation: "foobar", dob: "23/06/1993", sex: "Male", 
            city: "thrissur", state: "kerala", country: "India", zip: "680308", phno: "9745165109" ) }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:username) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:email) }
  it { should respond_to(:dob) }
  it { should respond_to(:sex) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:country) }
  it { should respond_to(:zip) }
  it { should respond_to(:phno) }
  
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  
  it { should be_valid }

  
  describe "name when blank" do
  
    before  { @user.name = " " }
    
    it { should_not be_valid }

  end

  describe "username when blank" do

    before  { @user.username = " " }
    
    it { should_not be_valid }

  end

  describe "email when blank" do
  
    before  { @user.email = " " }
    
    it { should_not be_valid }

  end

  describe "sex when not selected" do

    before  { @user.sex = " " }

    it { should_not be_valid }

  end

  describe "name when long" do
  
    before  { @user.name = "a" * 51 }
    
    it { should_not be_valid }

  end

  describe "username when long" do
  
    before  { @user.username = "a" * 21 }
    
    it { should_not be_valid }
  
  end

  describe "username when short" do

    before  { @user.username = "a" * 4 }

    it { should_not be_valid }

  end

  describe "email when invalid" do

    it "should be invalid" do
  
      address = %w[user@foo,com user_at_foo.org example.user@foo. foor@bar_baz.com foobar@baz+baz.com foo@bar..com]
      address.each do |addr|
        @user.email = addr
        expect(@user).not_to be_valid
      end

    end
  
  end

  describe "email when valid" do
  
    it "should be valid" do
    
      address = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      address.each do |addr|
        @user.email = addr
        expect(@user).to be_valid
      end
    
    end

  end

  describe "email when already taken" do

    before  do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.swapcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  
  end

  describe "username when already taken" do
  
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username.swapcase
      user_with_same_username.save
    end
    
    it { should_not be_valid }

  end

  describe "email when upcase" do
  
    it "should not be saved" do

      @user.email = @user.email.upcase
      @user.save
      expect(@user.reload.email).to eq @user.email.downcase

    end
  
  end

  describe "password when blank" do

    before  { @user.password = " ", @user.password_confirmation = " " }
    
    it { should_not be_valid }

  end

  describe "password confirmation when not matching" do

    before  { @user.password_confirmation = "invalid" }

    it { should_not be_valid }

  end

  
  describe "authenticate method" do

    before  { @user.save }
    let(:found_user) { User.find_by(username: @user.username) }

    describe "with valid password" do

      it { should eq found_user.authenticate(@user.password) }

    end

    describe "with invalid password" do

      let(:user_with_invalid_password) { found_user.authenticate("invalid") }
      
      it { should_not eq user_with_invalid_password }
      specify { expect(user_with_invalid_password).to be_false }

    end

  end

  describe "password when short" do

    before  { @user.password = @user.password_confirmation = "a" * 5 }

    it { should_not be_valid }

  end

  describe "password when long" do
  
    before  { @user.password = @user.password_confirmation = "a" * 41 }

    it { should_not be_valid }

  end

  describe "remember token" do
    
    before  { @user.save }

    its(:remember_token) { should_not be_blank }

  end

end
