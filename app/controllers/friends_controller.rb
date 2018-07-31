class FriendsController < ApplicationController
  before_action :set_user, only: :index
  before_action :set_friend, only: :destroy
  
  # GET    /users/:user_id/friends
  def index
    @friends = @user.friendships.pluck(:friend_id) #Friendship.where(user_id: @user.id)
    render json: @friends
  end

  
  # DELETE /users/:user_id/friends/:id
  def destroy
    # @user.remove_friend(@friend)
    @user.friends.destroy(@friend)
    head :no_content
  end

  private

  def set_friend
    set_user
    @friend = @user.friends.find_by_user_id(params[:id])
    if (@friend.nil?)
      head :not_found
    end
  end

  def set_user
    @user = User.find_by_id(params[:user_id])
    if (@user.nil?)
      head :not_found
    end
  end
end
