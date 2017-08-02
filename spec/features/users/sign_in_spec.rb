require 'rails_helper'

RSpec.feature 'Users sign in' do
  
  before do
    @user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Sign in'
  end
  
  scenario 'with valid credentials' do
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully')
    expect(page).not_to have_content('Sign in')
    expect(page).not_to have_content('Sign up')
  end
  
  scenario 'fail with invalid credentials' do
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'test'
    click_button 'Sign in'
    
    expect(page).to have_content('Invalid Email or password')
  end
end