require 'rails_helper'

RSpec.feature 'Listing Comments' do
  before do
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic)
    @post = FactoryGirl.create(:post, topic: @topic)
    @comment1 = FactoryGirl.create(:comment, post: @post, user: @user)
    (1..6).each do |i|
      instance_variable_set('@comment' + (i+1).to_s, FactoryGirl.create(:child_comment, 
      parent_comment: instance_variable_get('@comment' + i.to_s), post: @post))
    end
    visit '/'
    click_link 'Forum'
    click_link @topic.name
    click_link @post.title
  end
  
  scenario 'shows up to 5 child comments deep when viewing a post' do
    expect(page).to have_content(@comment1.content)
    expect(page).not_to have_content(@comment7.content)
    click_link 'see additional replies'
    expect(page).not_to have_content(@comment1.content)
    expect(page).to have_content(@comment7.content)
  end
  
  scenario 'shows up to 4 child comments deep when viewing a comment' do
    visit "/topics/#{@topic.id}/posts/#{@post.id}/comments/#{@comment2.id}"
    expect(page).to have_content(@comment2.content)
    expect(page).not_to have_content(@comment7.content)
    click_link 'see additional replies'
    expect(page).not_to have_content(@comment2.content)
    expect(page).to have_content(@comment7.content)
  end
  
  scenario 'shows basic information for each comment' do
    expect(page).to have_content("#{@user.username} - less than a minute ago")
  end
end