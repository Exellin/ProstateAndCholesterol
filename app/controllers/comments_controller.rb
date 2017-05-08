class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_comment, only: [:edit, :show, :update, :delete]
  before_action :require_same_user, only: [:edit, :update, :delete]
  before_action :check_deleted, only: [:edit, :update, :delete]
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      flash[:success] = "Your comment has been successfully created"
      redirect_to topic_post_comment_path(@topic, @post, @comment)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @comment.update(comment_params)
      flash[:success] = "Comment has been updated"
      redirect_to topic_post_comment_path(@comment)
    else
      render 'edit'
    end
  end
  
  def show
    @post = @comment.post
  end
  
  def delete
    @comment.content = "[deleted]"
    @comment.deleted = true
    @comment.save
    flash[:danger] = "Your comment has been successfully deleted"
    redirect_to topic_post_comment_path(@comment)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def require_same_user
    if current_user != @comment.user
      flash[:danger] = "You can only edit or delete your own content"
      redirect_to topic_post_comment_path(@comment)
    end
  end
  
  def check_deleted
    if @comment.deleted?
      flash[:danger] = "This comment is deleted"
      redirect_to topic_post_comment_path(@comment)
    end
  end
end