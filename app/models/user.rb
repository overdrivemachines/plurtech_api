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
	has_many :friend_requests, dependent: :destroy
	has_many :pending_friends, through: :friend_requests, source: :friend
	has_many :friendships, dependent: :destroy
	has_many :friends, through: :friendships

	def remove_friend(friend)
		current_user.friends.destroy(friend)
	end
end
