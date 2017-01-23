class CommentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json, :html

  def create
    @comment_hash = params[:comment]
    @obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])

    @comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])
    if @comment.save
      render :partial => "comments/comment", :locals => { :comment => @comment }, :layout => false, :status => :created
    else
      render :js => "alert('error saving comment');"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :json => @comment, :status => :ok
    else
      render :js => "alert('error deleting comment');"
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
  
end
