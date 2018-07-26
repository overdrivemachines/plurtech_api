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

# Friend Requests
User.all.each do |u|
	for i in 0..(rand(1..8)) do
		f = User.offset(rand(User.count)).first
		print "Request from " + u.name + ": " + u.id.to_s + " to " + f.name + ": " + f.id.to_s + " => "

		fr = FriendRequest.new(user_id: u.id, friend_id: f.id)
		if (fr.save)
			print "SUCCESS\n"
		else
			print "FAIL "
			print fr.errors.full_messages.to_s + "\n"
		end
	end
	puts ""
end

FriendRequest.all.each do |fr|
	random_number = rand(0..1)
	if (random_number == 1)
		puts fr.user_id.to_s + " is friends with " + fr.friend_id.to_s
		fr.accept
	end
end

# Friend
# User.all.each do |u|
# 	for i in 0..(rand(1..8)) do
# 		f = User.offset(rand(User.count)).first
# 		print u.name + ": " + u.id.to_s + " and " + f.name + ": " + f.id.to_s + " are friends => "
		
# 		fr = Friendship.new(user_id: u.id, friend_id: f.id)
# 		if (fr.save)
# 			print "SUCCESS\n"
# 		else
# 			print "FAIL "
# 			print fr.errors.full_messages.to_s + "\n"
# 		end
# 	end
# 	puts ""
# end