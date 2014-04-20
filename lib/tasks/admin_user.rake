namespace :db do

  desc "Create an admin user"
  task admin: :environment do
    make_admin
  end

end

def make_admin
  User.create!(name: "Administrator",
               username: "admin",
               email: "admin@example.com",
               password: "j9i9jk-5wewr",
               password_confirmation: "j9i9jk-5wewr",
               sex: "Male",
               admin: true)
end
