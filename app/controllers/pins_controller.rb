class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :comments, :add_comment, :remove_comment]	
  before_action :authenticate_user!, except: [:index]
  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def show
  	# @comment = @pin.comments.create
		@comments = @pin.comment_threads.order('created_at desc')
		@new_comment = Comment.build_from(@pin, current_user.id, "")
  end

	def new
	  @pin = current_user.pins.build
	end

	# def list
	#   @pins = current_user.pins
	#   @followed = current_user.all_follows
	# end

	# def followed
	#   @followed = current_user.all_follows
	# end

	def comments
		@comments = @pin.comment_threads.order('created_at desc')
	end

	def create
	  @pin = current_user.pins.build( pin_params )

	  if @pin.save
	  	redirect_to @pin, notice: "Pin was created"
	  else
	  	render "new"
	  end
	end

	def edit

	end

	def update
	  if @pin.update(pin_params)
	    redirect_to @pin, notice: "Pin was updated"
	  else
	  	render "edit"
	  end
	end

	def destroy
	  @pin.destroy
	  redirect_to root_path
	end

	def upvote
		if !current_user.voted_up_on? @pin
			@pin.upvote_by current_user if @pin.user_id != current_user.id
		else
			downvote
		end
		redirect_to :back
	end

	def downvote
		@pin.downvote_by current_user
	end

	def follow
    @pin = Pin.find(params[:id])
    if !current_user.following?(@pin)
    	current_user.follow(@pin) if @pin.user_id != current_user.id
    else
    	downfollow
    end
    redirect_to :back
  end

  def downfollow
    @pin = Pin.find(params[:id])
    current_user.stop_following(@pin)
  end

  def add_comment
  	comment = @pin.comments.create
  	comment.title = "First comment."
		comment.comment = params[:comment]
		comment.save
		redirect_to @pin
  end

	def remove_comment

	end

	private

	def pin_params
	  params.require(:pin).permit(:title, :description, :image)
	end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
