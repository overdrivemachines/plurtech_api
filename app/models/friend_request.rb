# == Schema Information
#
# Table name: friend_requests
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self
  validate :not_friends # don't allow friend requests if already friends
  validate :not_pending # don't allow friend requests if already pending

  def accept
    user.friends << friend
    destroy
  end

  # TODO: deny
  
  private 

  # user won’t be able to befriend himself
  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end

  # don't allow friend requests if already friends
  def not_friends
    errors.add(:friend, 'is already added') if user.friends.include?(friend)
  end

  # don't allow friend requests if already pending
  def not_pending
    errors.add(:friend, 'already requested friendship') if friend.pending_friends.include?(user)
  end
end
