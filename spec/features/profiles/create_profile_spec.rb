require 'rails_helper'

RSpec.feature "Profile created upon signup" do
  
  scenario do
    @user = FactoryGirl.build(:user)
    visit "/"
    click_link "Sign up"
    fill_in "Username", with: @user.username
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "Password Confirmation", with: @user.password
    click_button "Sign up"
    
    user = User.last
    expect(page).to have_content("Fill in your profile")
    profile = Profile.last
    expect(current_path).to eq(profile_path(profile))
    expect(profile.user_id).to eq(user.id)
  end
end