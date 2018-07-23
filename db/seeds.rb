# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 0..9 do	
	u = User.new
	u.name = Faker::Name.name
	u.email = Faker::Internet.free_email(u.name)
	u.username = Faker::Internet.user_name(u.name)
	u.phone = Faker::PhoneNumber.cell_phone
	# TODO format phone
	u.facebook = "https://www.facebook.com/DonaldTrump/"
	u.snapchat = ""
	u.twitter = "https://twitter.com/realDonaldTrump"
	u.instagram = "https://www.instagram.com/realdonaldtrump/"
	u.last_online = DateTime.now - Random.rand(0..3.0)
	u.save
end

for i in 1..((User.count) - 1) do
	
end