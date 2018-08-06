# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  
  # User needs to be present
  validates :user, presence: true
  # Friend needs to be present and prevent repeats of the same row
  # f = Friend.create(user_id: 2, friend_id: 3)
  #   commit transaction
  # f = Friend.create(user_id: 2, friend_id: 3)
  #   rollback transaction
  # f.errors.full_messages
  #  => ["Friend already"]
  validates :friend, presence: true, uniqueness: { scope: :user, message: "is already a friend" }
  validate :not_self # Don't allow a user to friend themselves

  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  private

  # Don't allow a user to friend themselves
  def not_self
    if user_id == friend_id
      errors.add(:friend, "can't be equal to user") 
    end
  end

  def create_inverse_relationship
    friend.friendships.create(friend: user)
  end

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end
end
