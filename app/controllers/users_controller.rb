class UsersController < ApplicationController
  before_filter :set_target, except: [:users, :pins, :friends]

  def users
    @users = User.all
  end

  def pins
    @pins = User.find(params[:id]).pins
    render template: 'lists/list'
  end

  def friends
    @friends = current_user.friends
    @pending = current_user.pending_friends
    @requsted = current_user.requested_friends
  end

  def send_request
    current_user.friend_request(@target) unless @target.nil? && current_user.friends_with?(@target)
    redirect_to users_list_path
  end

  def accept_request
    current_user.accept_request(@target) unless @target.nil? && current_user.friends_with?(@target)
    redirect_to friends_list_path
  end

  def decline_request
    current_user.decline_request(@target) unless @target.nil? && current_user.friends_with?(@target)
    redirect_to friends_list_path
  end

  def remove_friend
    current_user.remove_friend(@target) if !@target.nil? && current_user.friends_with?(@target)
    redirect_to friends_list_path
  end

  private

  def set_target
    @target = User.find(params[:id])
  end
end
