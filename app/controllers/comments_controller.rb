class CommentsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource
  before_action :find_comment, only: [:edit, :update]
  
  def index
    @comment    = Comment.new
    @comments   = Comment.where(parent_id: nil).order(created_at: :asc)
  end

  def create
    @comment  = current_user.comments.new(comment_params)
    @comment.save
  end

  def update
    @status = @comment.update(comment_params)
  end

  protected
  def comment_id
    params[:id]
  end

  def comment_params
    params.require(:comment).permit(:message, :parent_id)
  end

  def find_comment
    @comment = Comment.find(comment_id)
  end
end