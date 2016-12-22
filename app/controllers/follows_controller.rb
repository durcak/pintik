class FollowsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  # def create
  #   @user = User.find(params[:user_id])
  #   current_user.follow(@user)
  # end

  # def destroy
  #   @user = User.find(params[:user_id])
  #   current_user.stop_following(@user)
  # end

  def create

    @pin = Pin.find(params[:id])
    current_user.follow(@pin) if @pin.id != current_user.id
    redirect_to :back
  end

  def destroy
    @pin = Pin.find(params[:id])
    current_user.stop_following(@pin)
  end
end
