require 'rails_helper'

RSpec.feature "Creating Cholesterol History" do
  before do
    @owner = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:user)
    @profile = FactoryGirl.create(:profile, user: @owner)
    @cholesterol_history = FactoryGirl.build(:cholesterol_history, profile: @profile)
  end

  feature "as the owner", js: true do
    before do
      login_as(@owner)
      visit "/"
      click_link @owner.username
      click_link "edit cholesterol history"
      click_link "Add an entry"
    end

    scenario "with valid inputs" do
      find("input[name$='[total_cholesterol]']").set(@cholesterol_history.total_cholesterol)
      find("input[name$='[hdl]']").set(@cholesterol_history.hdl)
      find("input[name$='[ldl]']").set(@cholesterol_history.ldl)
      find("input[name$='[triglyceride]']").set(@cholesterol_history.triglyceride)
      find("input[name$='[glucose]']").set(@cholesterol_history.glucose)
      find("select[name$='[month]']").select(@cholesterol_history.month)
      find("select[name$='[year]']").select(@cholesterol_history.year)
      click_button "Update Cholesterol History"
      expect(page).to have_content("Your Cholesterol History has been successfully updated")
      click_link "edit cholesterol history"
      expect(find("input[name$='[total_cholesterol]']").value).to eq @cholesterol_history.total_cholesterol.to_s
      expect(find("input[name$='[hdl]']").value).to eq @cholesterol_history.hdl.to_s
      expect(find("input[name$='[ldl]']").value).to eq @cholesterol_history.ldl.to_s
      expect(find("input[name$='[triglyceride]']").value).to eq @cholesterol_history.triglyceride.to_s
      expect(find("input[name$='[glucose]']").value).to eq @cholesterol_history.glucose.to_s
      expect(find("select[name$='[month]']").find('option[selected]').text).to eq @cholesterol_history.month
      expect(find("select[name$='[year]']").find('option[selected]').text).to eq @cholesterol_history.year.to_s
    end

    scenario "with invalid inputs" do
      click_button "Update Cholesterol History"
      expect(page).to have_content("Cholesterol histories total cholesterol can't be blank")
      expect(page).to have_content("Cholesterol histories hdl can't be blank")
      expect(page).to have_content("Cholesterol histories ldl can't be blank")
      expect(page).to have_content("Cholesterol histories triglyceride can't be blank")
    end
  end

  feature "as another user" do
    before do
      login_as(@user)
    end

    scenario "through the user interface" do
      visit "/profiles/#{@profile.id}"
      expect(page).not_to have_content("edit cholesterol history")
    end

    scenario "by going directly to the route" do
      visit "/profiles/#{@profile.id}/cholesterol_histories/"
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
      visit "/profiles/#{@profile.id}/cholesterol_histories/"
      expect(page).to have_content("You must sign in or sign up to view this page")
      expect(current_path).to eq(new_user_registration_path)
    end
  end
end
