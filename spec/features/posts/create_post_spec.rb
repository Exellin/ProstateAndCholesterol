require 'rails_helper'

RSpec.feature 'Creating a Post' do
  before do
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic)
    @post = FactoryGirl.build(:post)
  end
  
  feature 'as a user' do
    before do
      login_as(@user)
      visit '/'
      click_link 'Forum'
      click_link "#{@topic.name}"
      click_link 'New Post'
    end
    
    scenario 'with valid inputs' do
      fill_in 'Title', with: @post.title
      fill_in 'Content', with: @post.content
      click_button 'Create Post'
      expect(page).to have_content('Your post has been successfully created')
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@post.content)
    end
    
    scenario 'with invalid inputs' do
      fill_in 'Title', with: ''
      fill_in 'Content', with: ''
      click_button 'Create Post'
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Content can't be blank")
    end
  end
      
  feature 'as a guest' do
    scenario 'through the user interface' do
      visit '/'
      click_link 'Forum'
      click_link "#{@topic.name}"
      click_link 'New Post'
      expect(page).to have_content('You must sign in or sign up to view this page')
      expect(current_path).to eq(new_user_registration_path)
    end
    
    scenario 'by going directly to the route' do
      visit "/topics/#{@topic.id}/posts/new"
      expect(page).to have_content('You must sign in or sign up to view this page')
      expect(current_path).to eq(new_user_registration_path)
    end
  end
end