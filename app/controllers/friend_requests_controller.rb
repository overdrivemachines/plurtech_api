class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:update, :destroy]
  before_action :set_user

  # GET    /users/:user_id/friend_requests
  def index
    @incoming = FriendRequest.where(friend: @user).pluck(:user_id)
    # @incoming = FriendRequest.where(friend: @user)
    @outgoing = @user.friend_requests.pluck(:friend_id)
    # @outgoing = @user.friend_requests

    render json: {
      incoming: @incoming,
      outgoing: @outgoing
    }.to_json
  end

  # GET    /users/:user_id/friend_requests/incoming
  def incoming
    incoming = FriendRequest.where(friend: @user).pluck(:user_id)
    incoming = FriendRequest.where(friend: @user).pluck(:user_id)
    render json: incoming
  end

  def cancel_incoming
    
  end

  # GET    /users/:user_id/friend_requests/outgoing
  def outgoing
    outgoing = @user.friend_requests.pluck(:friend_id)
    outgoing = @user.friend_requests.pluck(:friend_id)
    render json: outgoing
  end

  def cancel_outgoing
  end

  # POST   /users/:user_id/friend_requests
  def create
    # @friend_request = FriendRequest.new(friend_request_params)
    # @friend_request.user_id = @user.id

    # friend = User.find(params[:friend_id])
    # @friend_request = @user.friend_requests.new(friend: friend)
    
    @friend_request = @user.friend_requests.new(friend_request_params)

    if @friend_request.save
      head :created
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def update
    @friend_request.accept
    head :no_content
  end

  def destroy
    @friend_request.destroy
    head :no_content
  end

  private

  def set_friend
    
  end
  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # Only allow a trusted parameter "white list" through.
  def friend_request_params
    params.require(:friend_request).permit(:friend_id)
  end

end
