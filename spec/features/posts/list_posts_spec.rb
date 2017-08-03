require 'rails_helper'

RSpec.feature 'Listing Posts' do
  before do
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic)
    @posts_list = FactoryGirl.create_list(:post, 31, topic: @topic, user: @user)
    @first_post = @posts_list[0]
    @last_post = @posts_list[-1]
    @last_post_comment = FactoryGirl.create(:comment, post: @last_post, user: @user)
    visit '/'
    click_link 'Forum'
    click_link @topic.name
  end

  scenario 'shows 30 posts per page' do
    expect(page).to have_content(@last_post.title)
    expect(page).not_to have_content(@first_post.title)
    click_link '2'
    expect(page).not_to have_content(@last_post.title)
    expect(page).to have_content(@first_post.title)
  end

  scenario 'has a toggle to show content for each post', js: true do
    expect(page).not_to have_content(@last_post.content)
    expand_link = "a[data-remote='true'][href='/topics/#{@topic.id}/posts/#{@last_post.id}']"
    find(expand_link).click
    expect(page).to have_content(@last_post.content)
    last_post_content = find(:css, '.content')
    click_button 'collapse'
    expect(last_post_content).not_to be_visible
    find(:css, 'button').click
    expect(last_post_content).to be_visible
  end

  scenario 'shows basic information for each post' do
    expect(page).to have_content(@topic.name)
    expect(page).to have_content('0 comments')
    expect(page).to have_content('1 comment')
    expect(page).to have_content("created less than a minute ago by #{@user.username}")
  end
end
