require "spec_helper"

feature "native login process", :type => :feature do
  scenario "invalid password" do
    visit signup_path
    within(".input-container") do
      fill_in 'user_name', :with => 'John Doe'
      fill_in 'user_email', :with => 'john.doe@example.com'
      fill_in 'user_password', :with => 'I4mavstrongPassw0rd'
      fill_in 'user_password_confirmation', :with => 'I4mavstrongPassw0rd'
    end
    click_button 'Sign up'

    visit root_path
    within(".input-container") do
      fill_in 'session_email', :with => 'john.doe@example.com'
      fill_in 'session_password', :with => 'WrongPassword'
    end
    click_button 'Log in'
    expect(page).to have_content "Email and Password invalid! Try again!"
  end
end