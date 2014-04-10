namespace :db do

  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 username: "user",
                 email: "user@example.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 sex: "Male")
    99.times do |n|
      name = Faker::Name.name
      username = "user#{n+1}"
      email = "#{username}@example.com"
      password = "password"
      sex = "Male"
      User.create!(name: name,
                   username: username,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   sex: sex)
    end
  end

end
