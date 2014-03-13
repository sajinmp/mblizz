class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.date :dob
      t.string :sex
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :phno

      t.timestamps
    end
  end
end
