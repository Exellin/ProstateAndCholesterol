require 'rails_helper'

RSpec.feature 'Editing a Comment' do
  before do
    @owner = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic)
    @post = FactoryGirl.create(:post, topic: @topic)
    @comment = FactoryGirl.create(:comment, post: @post, user: @owner)
  end

  scenario 'as the owner of the comment' do
    login_as(@owner)
    visit '/'
    click_link 'Forum'
    click_link @topic.name
    click_link @post.title
    click_link 'edit comment'
    fill_in 'Content', with: 'edited content'
    click_button 'Update Comment'
    expect(page).to have_content('edited content')
    expect(page).to have_content('Comment has been updated')
    expect(page).not_to have_content(@comment.content)
  end

  feature 'as another user' do
    before do
      login_as(@user)
    end

    scenario 'through the user interface' do
      visit '/'
      click_link('Forum')
      click_link @topic.name
      click_link @post.title
      expect(page).not_to have_content('edit comment')
    end

    scenario 'by going directly to the route' do
      visit "/topics/#{@topic.id}/posts/#{@post.id}/comments/#{@comment.id}/edit"
      expect(page).to have_content('You can only edit or delete your own content')
      expect(current_path).to eq(root_path)
    end
  end
end
