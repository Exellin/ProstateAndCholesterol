require 'rails_helper'

RSpec.feature "Creating a Comment" do
  before do
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic)
    @post = FactoryGirl.create(:post)
    @parent_comment = FactoryGirl.create(:comment)
    @comment = FactoryGirl.build(:comment)
    @child_comment = FactoryGirl.build(:child_comment)
  end
  
  feature "as a user" do
    before do
      login_as(@user)
      visit "/"
      click_link "Forum"
      click_link "#{@topic.name}"
      click_link "#{@post.title}"
    end
    
    feature "in reply to a post" do
      before do
        click_link "Reply to Post"
      end
      
      scenario "with valid inputs" do
        fill_in "content", with: @comment.content
        click_button "Create Comment"
        expect(page).to have_content("Your comment has been successfully created")
        expect(page).to have_content(@post.title)
        expect(page).to have_content(@comment.content)
      end
      
      scenario "with invalid inputs" do
        fill_in "content", with: ""
        click_button "Create Comment"
        expect(page).to have_content("Content can't be blank")
      end
    end
    
    feature "in reply to a comment" do
      scenario "with valid inputs" do
        click_link "Reply to Comment"
        fill_in "content", with: @child_comment.content
        click_button "Create Comment"
        expect(page).to have_content(@post.title)
        expect(page).to have_content(@parent_comment.content)
        expect(page).to have_content(@child_comment.content)
      end
    end
  end
  
  feature "as a guest" do
    scenario "through the user interface" do
      visit "/"
      click_link "Forum"
      click_link "#{@topic.name}"
      click_link "#{@post.title}"
      click_link "Reply to Post"
      expect(page).to have_content("You must sign in or sign up to view this page")
      expect(current_path).to eq(new_user_registration_path)
    end
    
    scenario "by going directly to the route" do
      visit "/topics/#{@topic.id}/posts/#{@post.id}/comments/new"
      expect(page).to have_content("You must sign in or sign up to view this page")
      expect(current_path).to eq(new_user_registration_path)
    end
  end
end