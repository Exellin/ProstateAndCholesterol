require 'rails_helper'

RSpec.feature "Users sign up" do
  
  before(:each) do
    @user = FactoryGirl.build(:user)
    visit "/"
    click_link "Register and Tell Your Story"
  end
    
  scenario "anonymously" do
    check("Sign up Anonymously")
    page.should_not have_content("First name")
    page.should_not have_content("Last name")
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "Password confirmation", with: @user.password
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully")
  end
  
  scenario "with all credentials" do
    fill_in "First name", with: @user.first_name
    fill_in "Last name", with: @user.last_name
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "Password confirmation", with: @user.password
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully")
  end
  
  scenario "with invalid credentials" do
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "Password confirmation", with: @user.password
    click_button "Sign up"
    
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end
end