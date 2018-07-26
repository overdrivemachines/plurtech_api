class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]
  before_action :set_user

  def index
    # TODO: json
    @incoming = FriendRequest.where(friend: @user).pluck(:user_id)
    @outgoing = @user.friend_requests.pluck(:friend_id)

    render json: {
      incoming: @incoming,
      outgoing: @outgoing
    }.to_json

  end

  def create
    friend = User.find(params[:friend_id])
    @friend_request = @user.friend_requests.new(friend: friend)

    if @friend_request.save
      # TODO: json
      render :show, status: :created, location: @friend_request
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

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

end
