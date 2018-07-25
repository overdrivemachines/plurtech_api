# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  name        :string
#  email       :string
#  username    :string
#  phone       :string
#  facebook    :string
#  snapchat    :string
#  twitter     :string
#  instagram   :string
#  last_online :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class User < ApplicationRecord
	has_many :friend_requests, dependent: :destroy #outgoing friend requests
	has_many :incoming_friend_requests, class_name: "FriendRequest", foreign_key: "friend_id"
	
	has_many :friendships, dependent: :destroy
	has_many :friends, through: :friendships

	def send_friend_request(f)
		self.friend_requests.create(friend_id: f.id)
	end
	def cancel_friend_request(f)
		# TODO
	end
	def remove_friend(friend)
		current_user.friends.destroy(friend)
	end
end
