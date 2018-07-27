# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  username        :string
#  profile_picture :string
#  phone           :string
#  facebook        :string
#  snapchat        :string
#  twitter         :string
#  instagram       :string
#  last_online     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
	has_many :friend_requests, dependent: :destroy #outgoing friend requests
	has_many :incoming_friend_requests, class_name: "FriendRequest", foreign_key: "friend_id"
	
	has_many :friendships, dependent: :destroy
	has_many :friends, class_name: "Friendship", foreign_key: "friend_id"

	def send_friend_request(f)
		self.friend_requests.create(friend_id: f.id)
	end
	def cancel_friend_request(f)
		# TODO
	end
	def remove_friend(friend)
		self.friends.destroy(friend)
	end

	# Returns an array of user id's that friend requested you
	def list_incoming_friend_requests
		self.incoming_friend_requests.pluck(:user_id)
	end

	# Returns an array of user id's that you sent friend requests to
	def list_outgoing_friend_requests
	  self.friend_requests.pluck(:friend_id)
	end

	# Returns an array of user id's of your friends
	def list_friends
	  self.friendships.pluck(:friend_id)
	end

	# Accepts friend request from friend f
	def accept_friend_request(fid)
		if list_incoming_friend_requests.include?(fid)
			# TODO
			return true
		else
			return false
		end
	end

	# Denies friend request from friend f
	def deny_friend_request(fid)
	end
end
