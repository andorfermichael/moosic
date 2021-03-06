class SessionsController < ApplicationController
  # User logs in with email and password
  def create_conventional
    # Find user with given email and password
    user = User.find_by(email: params[:session][:email].downcase)

    # Encrypt given password and compare with password_digest in database
    if user && user.authenticate(params[:session][:password])
      # Save the user id inside the browser cookie.
      # This is how we keep the user # logged in
      # when they navigate around our website.
      session[:user_id] = user.id
      redirect_to(user_path(session[:user_id]), flash: :success)
    else
      redirect_to(root_path, flash: :error)
    end
  end

  # User logs in with a social media account
  def create_social
    # Get existing user or create and get the created user via method of user model
    user = User.find_or_create_with_omniauth(request.env['omniauth.auth'])

    # Authentication successfull
    if user
      session[:user_id] = user.id
      redirect_to(user_path(session[:user_id]))
    else
      redirect_to(root_path, flash: :error)
    end
  end

  # Logout = destroy session
  def destroy
    session[:user_id] = nil if current_user
    redirect_to(root_path, flash: :info)
  end
end
