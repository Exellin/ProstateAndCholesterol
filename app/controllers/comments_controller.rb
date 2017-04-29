class CommentsController < ApplicationController
  
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
  
  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end