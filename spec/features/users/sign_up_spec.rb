require 'rails_helper'

RSpec.feature "Users sign up" do
  
  before(:each) do
    @user = FactoryGirl.build(:user)
    visit "/"
    click_link "Register and Tell Your Story"
  end
    
  scenario "anonymously" do
    check("Sign up Anonymously")
    expect(page).not_to have_content("First name")
    expect(page).not_to have_content("Last name")
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "Password Confirmation", with: @user.password
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully")
  end
  
  scenario "with all credentials" do
    fill_in "First Name", with: @user.first_name
    fill_in "Last Name", with: @user.last_name
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "Password Confirmation", with: @user.password
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully")
  end
  
  scenario "fail with invalid credentials" do
    fill_in "Email", with: ""
    fill_in "Password", with: "test"
    fill_in "Password Confirmation", with: @user.password
    click_button "Sign up"
    
    expect(page).to have_content("Password is too short")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password Confirmation doesn't match Password")
  end
end