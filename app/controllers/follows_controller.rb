class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    followee = User.find(params[:followee_id])

    existing_follow = current_user.followee_relationships.find_by(followee_id: followee.id)

    if existing_follow.nil?
      follow = current_user.followee_relationships.build(followee_id: followee.id, status: 'pending')

      if follow.save
        send_follow_request_notification(followee, current_user)
        flash[:success] = "Follow request sent to #{followee.username}"
        redirect_to user_path(current_user)
      else
        flash[:error] = "Failed to send follow request"
        redirect_to user_path(current_user)
      end
    else
      flash[:error] = "You are already following #{followee.username} or have a pending request"
      redirect_to user_path(current_user)
    end
  end

  def destroy
    follow = current_user.followee_relationships.find_by(followee_id: params[:followee_id], status: 'pending')

    if follow
      follow.destroy
      flash[:success] = "Follow request to #{follow.followee.username} unsent"
      redirect_to user_path(current_user)
    else
      flash[:error] = "No pending follow request found"
      redirect_back(fallback_location: root_path)
    end
  end

  def accept
    follow = current_user.follower_relationships.find_by(follower_id: params[:follower_id], status: 'pending')

    if follow
      follow.update(status: 'accepted')
      flash[:success] = "#{follow.follower.username} is now following you"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Follow request not found"
      redirect_back(fallback_location: root_path)
    end
  end

  def followers
    @followers = current_user.follower_relationships
                             .where(status: 'accepted')
                             .includes(:follower)
                             .map(&:follower)  
    render 'followers'
  end

  def following
    @following = current_user.followee_relationships
                           .where(status: 'accepted')
                           .includes(:followee)
                           .map(&:followee)
    render 'following'
  end

  def pending_requests
    @pending_requests = current_user.follower_relationships.where(status: 'pending')
    render 'pending_requests'
  end

  private

  def send_follow_request_notification(followee, follower)
    Notification.create(
      receiver: followee,
      sender: follower,
      message: "#{follower.username} sent you a follow request"
    )
  end
end
