require 'rails_helper'

RSpec.feature 'Deleting a Post' do
  before do
    @owner = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic)
    @post = FactoryGirl.create(:post, topic: @topic, user: @owner)
  end

  scenario 'as the ownder of the post', js: true do
    login_as(@owner)
    visit '/'
    click_link 'Forum'
    click_link @topic.name
    click_link @post.title
    accept_confirm_from do
      click_link 'delete post'
    end
    expect(page).to have_content('Your post has been successfully deleted')
    expect(page).not_to have_content(@post.title)
    expect(page).not_to have_content(@post.content)
    expect(page).to have_content('[deleted]')
    visit topic_path(@topic)
    expect(page).not_to have_content('[deleted]')
  end
  
  scenario 'as another user' do
    login_as(@user)
    visit topic_post_path(@topic, @post)
    expect(page).not_to have_content('delete post')
  end
end
    