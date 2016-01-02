require "spec_helper"

feature "native registration process", :type => :feature do
  scenario "name is too short" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'Joe'
      fill_in 'user_email', :with => 'john.doe@example.com'
      fill_in 'user_password', :with => 'TestMeIfYouC4n'
      fill_in 'user_password_confirmation', :with => 'TestMeIfYou4C4n'
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
      fill_in 'user_password_confirmation', :with => 'TestMeIfYouC4n'
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
      fill_in 'user_password_confirmation', :with => 'TestMeIfYouC4n'
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
      fill_in 'user_password_confirmation', :with => 'TestMeIfYouC4n'
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
      fill_in 'user_password_confirmation', :with => 'TestMeIfYouC4n'
    end
    click_button 'Sign up'
    expect(page).to have_content "Email-Address has no valid format"
  end

  scenario "email is not unique" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'John Doe'
      fill_in 'user_email', :with => 'john.doe@gmail.com'
      fill_in 'user_password', :with => 'TestMeIfYouC4n'
      fill_in 'user_password_confirmation', :with => 'TestMeIfYouC4n'
    end
    click_button 'Sign up'

    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'John Doe'
      fill_in 'user_email', :with => 'john.doe@gmail.com'
      fill_in 'user_password', :with => 'TestMeIfYouC4n'
      fill_in 'user_password_confirmation', :with => 'TestMeIfYouC4n'
    end
    click_button 'Sign up'

    expect(page).to have_content "Email has already been taken"
  end

  scenario "password and password confirmation do not match" do
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

  scenario "password is too long" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'John Doe'
      fill_in 'user_email', :with => 'john.doe@example.com'
      fill_in 'user_password', :with => 'I4maverystrongPasswordbut14mt00l0ng'
      fill_in 'user_password_confirmation', :with => 'I4maverystrongPasswordbut14mt00l0ng'
    end
    click_button 'Sign up'
    expect(page).to have_content "Password is too long (maximum is 20 characters)"
  end

  scenario "valid data and successfull registration" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'John Doe'
      fill_in 'user_email', :with => 'john.doe@example.com'
      fill_in 'user_password', :with => 'I4mavstrongPassw0rd'
      fill_in 'user_password_confirmation', :with => 'I4mavstrongPassw0rd'
    end
    click_button 'Sign up'
    expect(page).to have_content "Sign up successfully. You can login now!"
  end
end