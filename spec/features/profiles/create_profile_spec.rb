require 'rails_helper'

RSpec.feature "Profile created upon signup" do
  
  before do
    @user = FactoryGirl.build(:user)
    @profile = FactoryGirl.build(:profile)
    visit "/"
    click_link "Sign up"
    fill_in "Username", with: @user.username
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    fill_in "Password Confirmation", with: @user.password
    click_button "Sign up"
  end
  
  scenario "and filled with valid credentials" do
    fill_in "First Name", with: @profile.first_name
    fill_in "Last Name", with: @profile.last_name
    fill_in "Birth Year", with: @profile.birth_year
    select(@profile.country_name, from: 'profile_country')
    fill_in "Years resided within 200 miles/320km of your current residence", 
    with: @profile.years_in_current_locale
    select('Caucasian', from: 'profile_race')
    fill_in "Ancestral Descent", with: @profile.ancestral_descent
    fill_in "Age Noticed Symptoms", with: @profile.age_noticed_symptoms
    fill_in "Age Urinary Malfunction", with: @profile.age_urinary_malfunction
    fill_in "Age Bladder Infection", with: @profile.age_bladder_infection
    fill_in "Your Story", with: @profile.story
    
    click_button "Create Profile"
    expect(page).to have_content("Your profile has been successfully created")
  end
    
  scenario "with no credentials filled" do
    click_button "Create Profile"
    expect(page).to have_content("First Name can't be blank")
    expect(page).to have_content("Last Name can't be blank")
    expect(page).to have_content("Birth Year can't be blank")
    expect(page).to have_content("Years resided within 200 miles/320km of your current residence can't be blank")
  end
end