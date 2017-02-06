class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote,
                                  :downvote, :comments, :add_comment, :remove_comment]
  load_and_authorize_resource

  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def show
    @comments = @pin.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@pin, current_user.id, "")
  end

  def new
    @pin = current_user.pins.build
  end

  def comments
    @comments = @pin.comment_threads.order('created_at desc')
  end

  def create
    @pin = current_user.pins.build(pin_params)

    if @pin.save
      redirect_to @pin, notice: "Pin was created"
    else
      render "new"
    end
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
      @pin.create_activity(:like, owner: current_user)
    else
      downvote
    end
    redirect_to :back
  end

  def downvote
    @pin.downvote_by current_user
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description, :image, :user_id)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end
end
