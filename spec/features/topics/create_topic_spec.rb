require 'rails_helper'

RSpec.feature 'Creating a Topic' do
  before do
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:admin)
    @topic = FactoryGirl.build(:topic)
  end

  feature 'as an administrator' do
    before do
      login_as(@admin)
      visit '/'
      click_link 'Forum'
      click_link 'New Topic'
    end

    scenario 'with valid inputs' do
      fill_in 'Name', with: @topic.name
      click_button 'Create Topic'
      expect(page).to have_content('A new topic has been successfully created')
      expect(page).to have_content(@topic.name)
    end

    scenario 'with invalid inputs' do
      fill_in 'Name', with: ''
      click_button 'Create Topic'
      expect(page).to have_content("Name can't be blank")
    end
  end

  feature 'as a regular user' do
    login_as(@user)

    scenario 'through the user interface' do
      visit '/'
      click_link 'Forum'
      expect(page).not_to have_content('New Topic')
    end

    scenario 'by going directly to the route' do
      visit '/topics/new'
      expect(current_path).to eq(root_path)
    end
  end
end
