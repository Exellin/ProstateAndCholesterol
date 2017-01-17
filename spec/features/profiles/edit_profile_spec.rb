require 'rails_helper'

RSpec.feature "Editing Profle" do
  before do
    @owner = FactoryGirl.create(:user)
    @profile = FactoryGirl.create(:profile, user: @owner)
    login_as(@owner)
  end
  
  scenario "with valid inputs" do
    visit "/"
    click_link(@owner.username)
    click_link "edit"
    fill_in "First Name", with: "Joe"
    old_first_name = @profile.first_name
    click_button "Update Profile"
    expect(page).to have_content("Joe")
    expect(page).not_to have_content(old_first_name)
  end
end
    
    
    