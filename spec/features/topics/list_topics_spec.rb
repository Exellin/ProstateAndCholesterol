require 'rails_helper'

RSpec.feature "Listing Topics" do
  before do
    @admin = FactoryGirl.create(:admin)
    @topic1 = FactoryGirl.create(:topic)
    @topic2 = FactoryGirl.create(:topic)
    @post1 = FactoryGirl.create(:post, user: @admin, topic: @topic1)
  end
  
  scenario "shows all topics" do
    visit "/"
    click_link "Forum"
    expect(page).to have_content(@topic1.name)
    expect(page).to have_content(@topic2.name)
    expect(page).to have_content("0 posts")
    expect(page).to have_content("1 post")
    expect(page).to have_content("last post: #{@post1.title} by #{@admin.username} less than a minute ago")
  end
end