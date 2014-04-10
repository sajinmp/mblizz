namespace :db do

  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 username: "user",
                 email: "user@example.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 sex: "Male",
                 admin: true)
    
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
    
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end

  end

end
