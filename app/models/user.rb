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

	has_many :posts, dependent: :destroy

	validates :name, presence: true, length: { in: 4..70 }
	validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :username, presence: true, uniqueness: true

	before_validation :downcase_fields

	def send_friend_request(f)
		self.friend_requests.create(friend_id: f.id)
	end
	def cancel_friend_request(f)
		self.friend_requests.find_by_friend_id(f.id).destroy
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
		fr = u.incoming_friend_requests.find_by_user_id(fid)
		if fr.nil?
			return false
		else
			fr.accept
			return true
		end
	end

	# Denies friend request from friend f
	def deny_friend_request(fid)
	end

	def downcase_fields
		self.email.downcase
		self.username.downcase
	end
end
