class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @comment    = Comment.new
    @comments   = Comment.all
  end
end