class SessionsController < ApplicationController
  def new
  end

  def create_conventional
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      # Save the user id inside the browser cookie.
      # This is how we keep the user # logged in
      # when they navigate around our website.
      session[:user_id] = user.id
      redirect_to users_path, notice: 'Logged in!'
    else
      redirect_to root_path, alert: 'Log in failed!'
    end
  end

  def create_social
    user = User.find_or_create_with_omniauth(request.env['omniauth.auth'])

    if user
      session[:user_id] = user.id
      redirect_to users_path, alert: 'Logged in!'
    else
      redirect_to root_path, alert: 'Log in failed!'
    end
  end

  def destroy
    if current_user
      session[:user_id] = nil
      flash[:success] = 'Logged out'
    end
    redirect_to root_path
  end
end