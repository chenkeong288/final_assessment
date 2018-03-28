class UsersController < ApplicationController

  def index
    
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: "Thank you for signing up"
    else
      render "new"
    end
  end

  # for Google Login
  def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])      # this code saves the user gmail account info into variable @user

      session[:user_id] = @user.id                                  # to set session in order to indicate current_user being the person logged in with google
      redirect_to root_path                                         # redirect to home page once signed in with Google
  end


private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end


end
