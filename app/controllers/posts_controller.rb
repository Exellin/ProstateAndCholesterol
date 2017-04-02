class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @topic = Topic.find(params[:topic_id])
    @post.user = current_user
    @post.topic = @topic
    if @post.save
      flash[:success] = "Your post has been successfully created"
      redirect_to topic_post_path(@topic, @post)
    else
      render 'new'
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end