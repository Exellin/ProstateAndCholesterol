require 'rails_helper'

RSpec.feature 'Editing a Post' do
  before do
    @owner = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic)
    @post = FactoryGirl.create(:post, topic: @topic, user: @owner)
  end

  scenario 'as the owner of the post' do
    login_as(@owner)
    visit '/'
    click_link 'Forum'
    click_link @topic.name
    click_link @post.title
    click_link 'edit post'
    fill_in 'Content', with: 'edited content'
    click_button 'Update Post'
    expect(page).to have_content('edited content')
    expect(page).to have_content('Post has been updated')
    expect(page).not_to have_content(@post.content)
  end
  
  feature 'as another user' do
    before do
      login_as(@user)
    end
    
    scenario 'through the user interface' do
      visit '/'
      click_link 'Forum'
      click_link @topic.name
      click_link @post.title
      expect(page).not_to have_content('edit post')
    end
    
    scenario 'by going directly to the route' do
      visit "/topics/#{@topic.id}/posts/#{@post.id}/edit"
      expect(page).to have_content('You can only edit or delete your own content')
      expect(current_path).to eq(topic_post_path(@topic, @post))
    end
  end
end
    