class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    # TODO: limit viewing all users
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    # TODO: find a nice way to show both user details and friends
    # render json: {
    #   user: @user,
    #   friends: @user.friends
    # }.to_json
    render json: @user
  end

  # GET /users/:user_id/feed
  def feed
    @user = User.find_by_id(params[:user_id])
    if (@user.nil?)
      head :not_found
    end
    @page = params[:page].to_i
    if (@page < 0)
      @page = 0
    end
    records_per_page = 5
    @activities = PublicActivity::Activity.order(created_at: :desc).where(owner_id: @user.list_friends, owner_type: "User").offset((@page - 1) * records_per_page).limit(records_per_page)
    render json: @activities
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
      # head :created, location: user_path(@user)
      # render json: {status: :created, message: "Successfully created User" user: @user}, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
      # render json: {status: :unprocessable_entity, errors: @user.errors}.to_json, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      # Avoid ActiveRecord::RecordNotFound
      # https://stackoverflow.com/questions/9709659/rails-find-getting-activerecordrecordnotfound
      # @user = User.find(params[:id])
      @user = User.find_by_id(params[:id])
      if (@user.nil?)
        head :not_found
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :username, :profile_picture, :phone, :facebook, :snapchat, :twitter, :instagram, :last_online)
    end
end
