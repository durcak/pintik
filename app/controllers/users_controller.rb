class UsersController < ApplicationController
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
		@user = User.find(params[:id])
		current_user.friend_request(@user)
		redirect_to users_list_path
	end

	def accept_request
		@user = User.find(params[:id])
		current_user.accept_request(@user)
		redirect_to friends_list_path
	end

	def decline_request
		@user = User.find(params[:id])
		current_user.decline_request(@user)
		redirect_to friends_list_path
	end

	def remove_friend
		@user = User.find(params[:id])
		current_user.remove_friend(@user)
		redirect_to friends_list_path
	end

end
