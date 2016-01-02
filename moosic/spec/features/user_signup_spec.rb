require "spec_helper"

feature "native registration process", :type => :feature do
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

  scenario "name is too long" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'Wolfgang Amadeus Johannes Chrysostomus Wolfgangus Theophilus Mozart'
      fill_in 'user_email', :with => 'john.doe@example.com'
      fill_in 'user_password', :with => 'TestMeIfYouC4n'
      fill_in 'user_password_confirmation', :with => 'TestMeIfYou4Can'
    end
    click_button 'Sign up'
    expect(page).to have_content "Name is too long (maximum is 30 characters)"
  end

  scenario "name must not be blank" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => ''
      fill_in 'user_email', :with => 'john.doe@example.com'
      fill_in 'user_password', :with => 'TestMeIfYouC4n'
      fill_in 'user_password_confirmation', :with => 'TestMeIfYou4Can'
    end
    click_button 'Sign up'
    expect(page).to have_content "Name can't be blank"
  end

  scenario "email must not be blank" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'John Doe'
      fill_in 'user_email', :with => ''
      fill_in 'user_password', :with => 'TestMeIfYouC4n'
      fill_in 'user_password_confirmation', :with => 'TestMeIfYou4Can'
    end
    click_button 'Sign up'
    expect(page).to have_content "Email can't be blank"
  end

  scenario "email has no valid format" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'John Doe'
      fill_in 'user_email', :with => '@john.doe.at'
      fill_in 'user_password', :with => 'TestMeIfYouC4n'
      fill_in 'user_password_confirmation', :with => 'TestMeIfYou4Can'
    end
    click_button 'Sign up'
    expect(page).to have_content "Email-Address has no valid format"
  end

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

  scenario "password is too short" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'John Doe'
      fill_in 'user_email', :with => 'john.doe@example.com'
      fill_in 'user_password', :with => 'Test'
      fill_in 'user_password_confirmation', :with => 'Test'
    end
    click_button 'Sign up'
    expect(page).to have_content "Password is too short (minimum is 9 characters)"
  end
end