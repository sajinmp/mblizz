FactoryGirl.define do
  
  factory :user do
    sequence(:name)         { |n| "Example User #{n}" }
    sequence(:username)     { |n| "example#{n}" }
    sequence(:email)        { |n| "example#{n}@example.com" }
    password                "password"
    password_confirmation   "password"
    sex                     "Male"
    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content   "Lorem ipsum"
    user
  end

end  
