class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    pin = Pin.find_by(id: params[:id])
    @comment = pin.comments.build
  end

  def create
    pin = Pin.find_by(id: params[:id])
    @comment = pin.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment has been created."
      # redirect_to :controller=>'pins',:action=>'show', id: pin.id
      redirect_to pin
    else

      flash[:alert] = "Comment has not been created."
    end
  end

  # def update 
  #   pin = Pin.find_by(id: params[:id])
  #   @comment = pin.comments.build(comment_params)
  #   @comment.user = current_user

  #   if @comment.save
  #     flash[:notice] = "Comment has been created."
  #     redirect_to :controller=>'pins',:action=>'show', id: pin.id
  #   else
  #     flash[:alert] = "Comment has not been created."
  #   end
  # end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment_id = params[:id]
    @comment.destroy
  end

  private    
    def comment_params
      params.permit(:comment)
    end
end
