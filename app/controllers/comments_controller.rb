class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :build_comment, only: [:create, :reply]
  
  def index
    @comment    = Comment.new
    @comments   = Comment.where(parent_id: nil)
  end

  def create
    if @comment.save
      redirect_to comments_path, notice: "You have successfuly created."
    else
      redirect_to comments_path, notice: "There is an error when create your comment."
    end
  end

  def reply
    if @comment.save
      redirect_to comments_path, notice: "You have successfuly created."
    else
      redirect_to comments_path, notice: "There is an error when create your comment."
    end
  end

  protected

  def comment_id
    params[:id]
  end

  def comment_params
    data              = params.require(:comment).permit(:message)
    data[:parent_id]  = comment_id if comment_id.present?
    data
  end

  def build_comment
    @comment = current_user.comments.new(comment_params)
  end
end