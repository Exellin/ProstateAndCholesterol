require 'rails_helper'

RSpec.feature 'Profile created upon signup' do
  before do
    @user = FactoryGirl.build(:user)
    @profile = FactoryGirl.build(:profile)
    visit '/'
    click_link 'Register'
    fill_in 'Username', with: @user.username
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    fill_in 'Password Confirmation', with: @user.password
    click_button 'Register'
  end

  scenario 'and filled with valid credentials' do
    fill_in 'First Name', with: @profile.first_name
    fill_in 'Last Name', with: @profile.last_name
    select(@profile.birth_year, from: 'profile_birth_year')
    select(@profile.country_name, from: 'profile_country')
    select(@profile.years_in_current_locale, from: 'profile_years_in_current_locale')
    select('Caucasian', from: 'profile_race')
    fill_in 'Ancestral Descent', with: @profile.ancestral_descent
    select(@profile.age_noticed_symptoms, from: 'profile_age_noticed_symptoms')
    select(@profile.age_urinary_malfunction, from: 'profile_age_urinary_malfunction')
    select(@profile.age_bladder_infection, from: 'profile_age_bladder_infection')
    fill_in 'Your Story', with: @profile.story

    click_button 'Create Profile'
    expect(page).to have_content('Your profile has been successfully created')
  end

  scenario 'with no credentials filled' do
    click_button 'Create Profile'
    expect(page).to have_content("First Name can't be blank")
    expect(page).to have_content("Last Name can't be blank")
  end
end
