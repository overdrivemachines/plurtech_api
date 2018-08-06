class FriendsController < ApplicationController
  before_action :set_user, only: [:index, :create]
  
  # GET    /users/:user_id/friends
  def index
    @friends = @user.friendships.pluck(:friend_id) #Friendship.where(user_id: @user.id)
    render json: @friends
  end

  # POST   /users/:user_id/friends
  # set_user and friendship_params are called before this action
  def create
    fr = @user.friendships.new(friendship_params)
    if (fr.save)
      head :created
    else
      render json: fr.errors, status: :unprocessable_entity
    end
  end

  
  # DELETE /users/:user_id/friends/:id
  # :id is the id of friend not the Friendship record's id
  def destroy
    # Check if @user and @friend are really friends
    f = Friendship.find_by_user_id_and_friend_id(params[:user_id], params[:id])
    if f.nil?
      head :not_found
    else
      f.destroy
      head :no_content
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end

  def set_user
    @user = User.find_by_id(params[:user_id])
    if (@user.nil?)
      head :not_found
    end
  end
end
