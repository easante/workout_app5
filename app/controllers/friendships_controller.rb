class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises
  end
  
  def create
    friend = User.find(params[:friend_id])
    params[:user_id] = current_user.id
    
    Friendship.create(friendship_params) unless current_user.follows_or_same?(friend)
    redirect_to root_path
  end
  
  def destroy
    @friendship = Friendship.find(params[:id])
    friendname = @friendship.friend.full_name
    
    if @friendship.destroy
      flash[:notice] = "#{friendname} unfollowed."
    else
      flash.now[:alert] = "#{friendname} could not be unfollowed."
    end
    redirect_to user_exercises_path(current_user)
  end
  
  private
  
  def friendship_params
    params.permit(:friend_id, :user_id)
  end
end