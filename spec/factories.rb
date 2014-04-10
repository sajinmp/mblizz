FactoryGirl.define do
  factory :user do
    sequence(:name)         { |n| "Example User #{n}" }
    sequence(:username)     { |n| "example#{n}" }
    sequence(:email)        { |n| "example#{n}@example.com" }
    password                "password"
    password_confirmation   "password"
    sex                     "Male"
  end
end  
