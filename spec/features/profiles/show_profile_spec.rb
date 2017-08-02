require 'rails_helper'

RSpec.feature 'Viewing a users profile' do
  
  before do
    @owner = FactoryGirl.create(:user)
    @profile = FactoryGirl.create(:profile, user: @owner)
  end
  
  scenario 'as the owner of the profile' do
    login_as(@owner)
    visit '/'
    click_link(@owner.username)
    expect(page).to have_content(@profile.story)
    expect(page).to have_content(@profile.first_name)
    expect(page).to have_content(@profile.last_name)
    expect(page).to have_content(@profile.birth_year)
    expect(page).to have_content(@profile.city)
    expect(page).to have_content(@profile.state_name)
    expect(page).to have_content(@profile.country_name)
    expect(page).to have_content(@profile.years_in_current_locale)
    expect(page).to have_content(@profile.ancestral_descent)
    expect(page).to have_content(@profile.age_noticed_symptoms)
    expect(page).to have_content(@profile.age_urinary_malfunction)
    expect(page).to have_content(@profile.age_bladder_infection)
  end
  
  scenario 'as a guest to the website' do
    visit "/profiles/#{@profile.id}"
    expect(page).to have_content(@owner.username)
    expect(page).to have_content(@profile.story)
    expect(page).not_to have_content(@profile.first_name)
    expect(page).not_to have_content(@profile.last_name)
    expect(page).not_to have_content(@profile.birth_year)
    expect(page).not_to have_content(@profile.city)
    expect(page).not_to have_content(@profile.state_name)
    expect(page).not_to have_content(@profile.country_name)
    expect(page).not_to have_content(@profile.years_in_current_locale)
    expect(page).not_to have_content(@profile.ancestral_descent)
    expect(page).not_to have_content(@profile.age_noticed_symptoms)
    expect(page).not_to have_content(@profile.age_urinary_malfunction)
    expect(page).not_to have_content(@profile.age_bladder_infection)
  end


end