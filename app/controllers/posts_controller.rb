class PostsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, except: [:show]
  before_action :set_post, only: [:edit, :show, :update, :delete]
  before_action :require_same_user, only: [:edit, :update, :delete]
  before_action :check_deleted, only: [:edit, :update, :delete]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @topic = Topic.find(params[:topic_id])
    @post.user = current_user
    @post.topic = @topic
    if @post.save
      flash[:success] = 'Your post has been successfully created'
      redirect_to topic_post_path(@topic, @post)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post has been updated'
      redirect_to topic_post_path(@post)
    else
      render 'edit'
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def delete
    @post.title = '[deleted]'
    @post.content = '[deleted]'
    @post.deleted = true
    @post.save
    flash[:danger] = 'Your post has been successfully deleted'
    redirect_to topic_post_path(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_same_user
    return if current_user == @post.user
    flash[:danger] = 'You can only edit or delete your own content'
    redirect_to topic_post_path(@post)
  end

  def check_deleted
    return unless @post.deleted?
    flash[:danger] = 'This post is deleted'
    redirect_to topic_post_path(@post)
  end
end
