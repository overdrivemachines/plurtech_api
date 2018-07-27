a = User.first
b = User.find(2)
fr = FriendRequest.new
fr.user_id = a.id
fr.friend_id = b.id
fr.save

FriendRequest.create(user_id: 1, friend_id: 2)

######################
# ERROR CHECKING SETUP
######################

u1 = User.create(name: "Dipen Chauhan", email: "get.dipen@gmail.com")
u2 = User.create(name: "AA", email: "a@a.com")
u3 = User.create(name: "BB", email: "b@b.com")
u4 = User.create(name: "CC", email: "c@c.com")

# u1 has no friend requests sent
u1.friend_requests.count

###################################
# TESTING FRIEND REQUEST AND ACCEPT
###################################
# u1 sending req to 3, 4
f = FriendRequest.create(user_id: 1, friend_id: 3)
f = FriendRequest.create(user_id: 1, friend_id: 4)
# u3 sending req to 2, 4 
f = FriendRequest.create(user_id: 3, friend_id: 2)
f = FriendRequest.create(user_id: 3, friend_id: 4)

u1.friend_requests.pluck(:friend_id)

u1.friend_requests.where(friend_id: 3)[0].accept
u1.friend_requests.pluck(:friend_id)




#####################
# TESTING FRIENDSHIPS
#####################
f = Friendship.create(user_id: 2, friend_id: 3)
f = Friendship.create(user_id: 2, friend_id: 4)
User.find(2).friendships.pluck(:friend_id)

##################################
# ERROR CHECKING for FriendRequest
##################################
# TODO: User absent
f = FriendRequest.create(friend_id: 3)

# Duplicate Friend Requests
#  => ["Friend has already been taken"]
f = FriendRequest.create(user_id: 2, friend_id: 3)
f = FriendRequest.create(user_id: 2, friend_id: 3)
f.errors.full_messages 

# Friend requests to yourself
#  => ["Friend can't be equal to user"] 
f = FriendRequest.create(user_id: 1, friend_id: 1)
f.errors.full_messages

# TODO: Friend request if already friends
f = FriendRequest.create(user_id: 1, friend_id: 2)
f.accept
f = FriendRequest.create(user_id: 1, friend_id: 2)

# Friend requests if already pending
#  => ["Friend already requested friendship"]
f = FriendRequest.create(user_id: 3, friend_id: 4)
f = FriendRequest.create(user_id: 4, friend_id: 3)
f.errors.full_messages

############################
# ERROR CHECKING for Friends
############################
# User absent
#  => ["User must exist", "User can't be blank"]
f = Friendship.create(friend_id: 3)
f.errors.full_messages 

# Friend absent
#  => ["Friend must exist", "Friend can't be blank"]
f = Friendship.create(user_id: 3)
f.errors.full_messages 

# Duplicate Friend Requests
#  => ["Friend has already been taken"]
f = Friendship.create(user_id: 2, friend_id: 3)
f = Friendship.create(user_id: 2, friend_id: 3)
f.errors.full_messages 

# Friend requests to yourself
#  => ["Friend can't be equal to user"] 
f = Friendship.create(user_id: 1, friend_id: 1)
f.errors.full_messages

# TODO: Friend request if already friends
f = Friendship.create(user_id: 1, friend_id: 2)
f.accept
f = Friendship.create(user_id: 1, friend_id: 2)

# Friend requests if already pending
#  => ["Friend already requested friendship"]
f = Friendship.create(user_id: 3, friend_id: 4)
f = Friendship.create(user_id: 4, friend_id: 3)
f.errors.full_messages




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