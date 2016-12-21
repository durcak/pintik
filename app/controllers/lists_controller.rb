class ListsController < ApplicationController
	def list
	  @pins = current_user.pins
	end
end
