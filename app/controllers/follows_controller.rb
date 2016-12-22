class FollowsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def create
    @pin = Pin.find(params[:id])
    if !current_user.following?(@pin)
      current_user.follow(@pin) if @pin.user_id != current_user.id
    else
      destroy
    end
    redirect_to :back
  end

  def destroy
    @pin = Pin.find(params[:id])
    current_user.stop_following(@pin)
  end
end
