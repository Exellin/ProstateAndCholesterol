require 'rails_helper'

RSpec.feature "Users sign up" do
  
  before(:each) do
    @user = FactoryGirl.build(:user)
    visit "/"
    click_link "Register and Tell Your Story"
  end
  
  scenario "with all credentials" do
    fill_in "Username", with: @user.username
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "Password Confirmation", with: @user.password
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully")
    expect(page).to have_content(@user.username)
  end
  
  scenario "fail with invalid credentials" do
    fill_in "Username", with: "ok"
    fill_in "Email", with: ""
    fill_in "Password", with: "test"
    fill_in "Password Confirmation", with: @user.password
    click_button "Sign up"
    
    expect(page).to have_content("Username is too short")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password is too short")
    expect(page).to have_content("Password Confirmation doesn't match Password")
  end
end