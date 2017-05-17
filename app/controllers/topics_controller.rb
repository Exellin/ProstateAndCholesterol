class TopicsController < ApplicationController
  include UserAccess
  before_action :require_admin, except: [:show, :index]
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def index
    @topics = Topic.all
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:success] = "A new topic has been successfully created"
      redirect_to topics_path
    else
      render 'new'
    end
  end
      
  private
  
  def topic_params
    params.require(:topic).permit(:name)
  end
end