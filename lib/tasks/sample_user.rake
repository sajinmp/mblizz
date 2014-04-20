namespace :db do

  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end

end

def make_users

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
  
end
  
def make_microposts

  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end

end

def make_relationships

  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }

end
