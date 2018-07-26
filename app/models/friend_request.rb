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
  
  # User needs to be present
  validates :user_id, presence: true
  
  # Friend needs to be present and prevent repeats of the same row
  # f = FriendRequest.create(user_id: 2, friend_id: 3)
  #   commit transaction
  # f = FriendRequest.create(user_id: 2, friend_id: 3)
  #   rollback transaction
  # f.errors.full_messages
  #  => ["Friend cannot be sent a request. User already requested friendship"]
  validates :friend, presence: true, uniqueness: { scope: :user, message: "cannot be sent a request. User already requested friendship" }


  validate :not_self # Don't allow friend requests to yourself
  validate :not_friends # Don't allow friend requests if already friends
  validate :not_pending # Don't allow friend requests if already pending

  def accept
    # TODO: only allow user with incoming friendship to accept
    # puts "user: " + user.name
    # puts "self.user: " + self.user.name
    # puts "friend: " + friend.name
    # Not working:
    # user.friends << friend
    fr = Friendship.new(user_id: user_id, friend_id: friend_id)
    if(fr.save)
      destroy
    else
      puts fr.errors.full_messages.to_s
    end
  end

  def deny
    destroy
  end
  
  private 

  # Don't allow friend requests to yourself
  # f = FriendRequest.create(user_id: 1, friend_id: 1)
  # f.errors.full_messages
  #   => ["Friend can't be equal to user"]
  def not_self
    if (user_id == friend_id)
      errors.add(:friend, "can't be equal to user")
    end
  end

  # don't allow friend requests if already friends
  # TODO: verify
  def not_friends
    if user.friends.include?(friend)
      errors.add(:friend, 'is already added') 
    end  
  end

  # Don't allow friend requests if already pending
  # Can't send a request to a friend who has already requested you to be thier friend
  # f = FriendRequest.create(user_id: 3, friend_id: 4)
  #   commit transaction
  # f = FriendRequest.create(user_id: 4, friend_id: 3)
  #   rollback transaction
  # f.errors.full_messages
  #   => ["Friend already requested friendship"]
  # u4.incoming_friend_requests.include?(u3.friend_requests)
  def not_pending
    if user_id.blank?
      return
    end
    if user.incoming_friend_requests.pluck(:user_id).include?(friend_id)
      errors.add(:friend, 'already requested friendship')
    end
  end
end
