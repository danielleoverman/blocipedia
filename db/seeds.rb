# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

10.times do
    user = User.new(
      email:    Faker::Internet.email,
      password: Faker::Lorem.characters(10)
    )
   user.save!
  
   end

 users = User.all


# Create Wikis
 15.times do
   wiki = Wiki.create!(
     user: users.sample,
     title: Faker::Lorem.sentence,
     body: Faker::Lorem.paragraph
   )

end

wikis= Wiki.all
