class RelationshipsController < ApplicationController
  def follow
    current_user.follow(params[:id])
    redirect_to request.referer
  end

  def unfollow
    current_user.unfollow(params[:id]).destroy
    redirect_to request.referer
  end

  def followings
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end
end
