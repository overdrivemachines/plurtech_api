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

User.all.each do |u|
	for i in 0..(rand(1..8)) do
		f = User.offset(rand(User.count)).first
		FriendRequest.create(user_id: u.id, friend_id: f.id)

		puts u.name + " sent a friend request to " + f.name
	end
	puts ""
end

a = User.first
b = User.find(2)
fr = FriendRequest.new
fr.user_id = a.id
fr.friend_id = b.id
fr.save

FriendRequest.create(user_id: 1, friend_id: 2)

u1 = User.create(name: "Dipen Chauhan", email: "get.dipen@gmail.com")
u2 = User.create(name: "AA", email: "a@a.com")
u3 = User.create(name: "BB", email: "b@b.com")
u4 = User.create(name: "CC", email: "c@c.com")

# u1 has no friend requests sent
u1.friend_requests.count

##################################
# ERROR CHECKING for FriendRequest
##################################
# User absent
f = FriendRequest.create(friend_id: 3)

# Duplicate Friend Requests
f = FriendRequest.create(user_id: 2, friend_id: 3)
f = FriendRequest.create(user_id: 2, friend_id: 3)
f.errors.full_messages

# Friend requests to yourself
f = FriendRequest.create(user_id: 1, friend_id: 1)
f.errors.full_messages

# TODO: Friend request if already friends
f = FriendRequest.create(user_id: 1, friend_id: 1)
f.accept
f = FriendRequest.create(user_id: 1, friend_id: 1)

# Friend requests if already pending
f = FriendRequest.create(user_id: 3, friend_id: 4)
f = FriendRequest.create(user_id: 4, friend_id: 3)
f.errors.full_messages

############################
# ERROR CHECKING for Friends
############################

# u1 sending a friend request to u2
# Dipen Chauhan sends a friend request to AA
u1.friend_requests.create(friend_id: u2.id)
fr = FriendRequest.new
fr.user_id = u1.id
fr.friend_id = u2.id
fr.save
# u1 sending a friend request to u3
# Dipen Chauhan sends a friend request to BB
u1.friend_requests.create(friend_id: u3.id)

# Show all friend requests made by u1
u1.friend_requests

u1.pending_friends