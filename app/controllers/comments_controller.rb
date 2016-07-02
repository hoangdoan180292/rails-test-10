class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @comment    = Comment.new
    @comments   = Comment.where(parent_id: nil)
  end

  def create
    @comment  = current_user.comments.new(comment_params)
    @status   = @comment.save
  end

  protected
  def comment_params
    params.require(:comment).permit(:message, :parent_id)
  end
end