class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:location].present?
      @posts = Post.where(location: params[:location])
    else
      @posts = Post.all
    end
    # @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = @post.comments.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if post_params[:latitude] && post_params[:longitude]
      # @post.location = GoogleMapsService.get_location(params[:latitude], params[:longitude])
      @post.location = Geocoder.search([post_params[:latitude], post_params[:longitude]]).first.address
    elsif request.location
      @post.location = request.location.address
    end

    if @post.save
      redirect_to posts_url, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @post
  end

  def update
    if @post.update(post_params)
      redirect_to posts_url, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :latitude, :longitude, :location, images: [])
  end
end
