class ListsController < ApplicationController
	def list
	  @pins = current_user.pins
	end

	def followed
	  @followed = current_user.following_by_type('Pin')
	end
end
