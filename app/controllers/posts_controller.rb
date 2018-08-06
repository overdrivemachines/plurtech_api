class PostsController < ApplicationController
  before_action :set_user, only: [:index, :create]
  before_action :set_post, only: [:show, :update, :destroy]

  # GET    /users/:user_id/posts
  def index
    @posts = @user.posts

    render json: @posts
  end

  # GET    /posts/:id
  def show
    render json: @post
  end

  # POST   /users/:user_id/posts
  def create
    @post = @user.posts.new(post_params)

    if @post.save
      @post.create_activity(:create, :owner => @user)
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT  /posts/:id
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:id
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_id(params[:id])
      if (@post.nil?)
        head :not_found
      end
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:body, :has_image, :image_url)
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
      if (@user.nil?)
        head :not_found
      end
    end
end
