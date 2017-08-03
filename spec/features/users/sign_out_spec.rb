require 'rails_helper'

RSpec.feature 'Users sign out' do
  scenario do
    @user = FactoryGirl.create(:user)
    login_as(@user)
    visit '/'
    click_link('Sign out')
    expect(page).to have_content('Signed out successfully')
  end
end
