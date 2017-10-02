require 'rails_helper'

RSpec.feature 'Users sign up' do
  before(:each) do
    @user = FactoryGirl.build(:user)
    visit '/'
    click_link 'Register and tell your story'
  end

  scenario 'with all credentials' do
    fill_in 'Username', with: @user.username
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    fill_in 'Password Confirmation', with: @user.password
    click_button 'Sign up'
    expect(page).to have_content('You have signed up successfully')
    expect(page).to have_content('Create Your Profile')
  end

  scenario 'fail with invalid credentials' do
    fill_in 'Username', with: 'ok'
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'test'
    fill_in 'Password Confirmation', with: @user.password
    click_button 'Sign up'

    expect(page).to have_content('is too short (minimum is 3 characters)')
    expect(page).to have_content("can't be blank")
    expect(page).to have_content('is too short (minimum is 6 characters)')
    expect(page).to have_content("doesn't match Password")
  end
end
