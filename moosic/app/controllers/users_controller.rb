class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  # Index is default view
  def index
  end

  def show

  end

  # Create new user object when rendering new user view
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  # Stores user in database
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
