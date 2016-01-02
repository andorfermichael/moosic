require "spec_helper"

feature "native registration process", :type => :feature do
  scenario "password and password confirmation do NOT match" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'John Doe'
      fill_in 'user_email', :with => 'john.doe@example.com'
      fill_in 'user_password', :with => 'TestMeIfYouC4n'
      fill_in 'user_password_confirmation', :with => 'TestMeIfYouCan'
    end
    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario "name is too short" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'Joe'
      fill_in 'user_email', :with => 'john.doe@example.com'
      fill_in 'user_password', :with => 'TestMeIfYouC4n'
      fill_in 'user_password_confirmation', :with => 'TestMeIfYou4Can'
    end
    click_button 'Sign up'
    expect(page).to have_content "Name is too short (minimum is 4 characters)"
  end
end