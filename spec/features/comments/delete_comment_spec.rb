require 'rails_helper'

RSpec.feature 'Deleting a Comment' do
  before do
    @owner = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic)
    @post = FactoryGirl.create(:post, topic: @topic)
    @comment = FactoryGirl.create(:comment, post: @post, user: @owner)
  end
  
  scenario 'as the owner of the post', js: true do
    login_as(@owner)
    visit '/'
    click_link 'Forum'
    click_link "#{@topic.name}"
    click_link "#{@post.title}"
    accept_confirm_from do
      click_link 'delete comment'
    end
    expect(page).to have_content('Your comment has been successfully deleted')
    expect(page).not_to have_content(@comment.content)
    expect(page).to have_content('[deleted]')
  end
  
  scenario 'as another user' do
    login_as(@user)
    visit topic_post_comment_path(@topic, @post, @comment)
    expect(page).not_to have_content('delete comment')
  end
end
