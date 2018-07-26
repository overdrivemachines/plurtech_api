class FriendsController < ApplicationController
  before_action :set_user
  before_action :set_friend, only: :destroy
  def index
    @friends = @user.friendships.pluck(:friend_id) #Friendship.where(user_id: @user.id)
    render json: @friends
  end

  def destroy
    @user.remove_friend(@friend)
    head :no_content
  end

  private

  def set_friend
    @friend = @user.friends.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
