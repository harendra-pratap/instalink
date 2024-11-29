class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @is_current_user = @user == current_user
    @followers_count = @user.follower_relationships.count
    @following_count = @user.followee_relationships.count

    if !@is_current_user
      @follow_request = current_user.followee_relationships.find_by(followee: @user)
      @follow_button_text = @follow_request.nil? ? "Follow" : "Unfollow"
    end
  end

  def search
    @users = User.where("username LIKE ?", "%#{params[:query]}%").limit(10)
    render :search_results # Render the search results view
  end
end
