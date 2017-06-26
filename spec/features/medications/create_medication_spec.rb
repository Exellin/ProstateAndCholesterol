require 'rails_helper'

RSpec.feature "Creating Medication" do
  before do
    @owner = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)
    @profile = FactoryGirl.create(:profile, user: @owner)
    @medication = FactoryGirl.build(:medication, profile: @profile)
  end

  feature "as the owner", js: true do
    before do
      login_as(@owner)
      visit "/"
      click_link @owner.username
      click_link "edit medications"
    end

    scenario "with valid inputs" do
      click_link "Add an entry"
      find("select[name$='[purpose]']").select(@medication.purpose)
      find("input[name$='[name]']").set(@medication.name)
      find("input[name$='[strength]']").set(@medication.strength)
      find("input[name$='[dosage]']").set(@medication.dosage)
      find("select[name$='[age_recommended]']").select(@medication.age_recommended)
      find("select[name$='[age_prescribed]']").select(@medication.age_prescribed)
      find("select[name$='[month_last_used]']").select(@medication.month_last_used)
      find("select[name$='[year_last_used]']").select(@medication.year_last_used)
      find("input[name$='[still_using]']").set(@medication.still_using)
      click_button "Update Medications"
      expect(page).to have_content("Your Medications have been successfully updated")
      click_link "edit medications"
      expect(find("select[name$='[purpose]']").find('option[selected]').text).to eq @medication.purpose
      expect(find("input[name$='[name]']").value).to eq @medication.name
      expect(find("input[name$='[strength]']").value).to eq @medication.strength.to_s
      expect(find("input[name$='[dosage]']").value).to eq @medication.dosage.to_s
      expect(find("select[name$='[age_recommended]']").find('option[selected]').text).to eq @medication.age_recommended.to_s
      expect(find("select[name$='[age_prescribed]']").find('option[selected]').text).to eq @medication.age_prescribed.to_s
      expect(find("select[name$='[month_last_used]']").find('option[selected]').text).to eq @medication.month_last_used
      expect(find("select[name$='[year_last_used]']").find('option[selected]').text).to eq @medication.year_last_used.to_s
      if @medication.still_using
        expect(find("input[name$='[still_using]']")).to be_checked
      else
        expect(find("input[name$='[still_using]']")).not_to be_checked
      end
    end

    scenario "with invalid inputs" do
      click_link "Add an entry"
      click_button "Update Medications"
      expect(page).to have_content("Medications name can't be blank")
      expect(page).to have_content("Medications strength can't be blank")
      expect(page).to have_content("Medications dosage can't be blank")
    end

    scenario "with no inputs" do
      click_button "Update Medications"
      expect(page).to have_content("Your profile has been successfully updated")
    end
  end

  feature "as another user" do
    before do
      login_as(@user)
    end

    scenario "through the user interface" do
      visit "/profiles/#{@profile.id}"
      expect(page).not_to have_content("edit medications")
    end

    scenario "by going directly to the route" do
      visit "/profiles/#{@profile.id}/medications/"
      expect(page).to have_content("You can only edit or delete your own content")
      expect(current_path).to eq(root_path)
    end
  end

  feature "as a guest" do
    scenario "through the user interface" do
      visit "/profiles/#{@profile.id}"
      expect(page).not_to have_content("edit medications")
    end

    scenario "by going directly to the route" do
      visit "/profiles/#{@profile.id}/medications/"
      expect(page).to have_content("You must sign in or sign up to view this page")
      expect(current_path).to eq(new_user_registration_path)
    end
  end
end
