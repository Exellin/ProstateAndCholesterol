require 'rails_helper'

RSpec.feature "Creating PSA History" do
  before do
    @owner = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)
    @profile = FactoryGirl.create(:profile, user: @owner)
    @psa_history = FactoryGirl.build(:psa_history, profile: @profile)
  end

  feature "as the owner", js: true do
    before do
      login_as(@owner)
      visit "/"
      click_link @owner.username
      click_link "edit psa history"
    end

    scenario "with valid inputs" do
      click_link "Add an entry"
      find("input[name$='[psa]']").set(@psa_history.psa)
      find("select[name$='[year]']").select(@psa_history.year)
      find("select[name$='[month]']").select(@psa_history.month)
      click_button "Update PSA History"
      expect(page).to have_content("Your PSA History has been successfully updated")
      click_link "edit psa history"
      expect(find("input[name$='[psa]']").value).to eq @psa_history.psa.to_s
      expect(find("select[name$='[year]']").find('option[selected]').text).to eq @psa_history.year.to_s
      expect(find("select[name$='[month]']").find('option[selected]').text).to eq @psa_history.month
    end

    scenario "with invalid inputs" do
      click_link "Add an entry"
      click_button "Update PSA History"
      expect(page).to have_content("Psa histories psa can't be blank")
    end

    scenario "with no inputs" do
      click_button "Update PSA History"
      expect(page).to have_content("Your profile has been successfully updated")
    end
  end

  feature "as another user" do
    before do
      login_as(@user)
    end

    scenario "through the user interface" do
      visit "/profiles/#{@profile.id}"
      expect(page).not_to have_content("edit psa history")
    end

    scenario "by going directly to the route" do
      visit "/profiles/#{@profile.id}/psa_histories/"
      expect(page).to have_content("You can only edit or delete your own content")
      expect(current_path).to eq(root_path)
    end
  end

  feature "as a guest" do
    scenario "through the user interface" do
      visit "/profiles/#{@profile.id}"
      expect(page).not_to have_content("edit psa history")
    end

    scenario "by going directly to the route" do
      visit "/profiles/#{@profile.id}/psa_histories/"
      expect(page).to have_content("You must sign in or sign up to view this page")
      expect(current_path).to eq(new_user_registration_path)
    end
  end
end
