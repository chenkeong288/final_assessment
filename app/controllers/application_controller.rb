class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private 

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]      # save this line of logic in @current_user variable because the current_user method will be called many times
  end

  helper_method :current_user                      # the current_user method can only be called inside the user controller, so in order to enable it to be used inside of the view, we call the helper_method in the controller here to turn the current_user method here into helper_method to enable it to be accessed from the view

  def authorize
    redirect_to new_session_path, alert: "Not authorized. Kindly login to perform action." if current_user.nil?
  end


  # method to check if user has signed_in? Obtained code from Clearance gem in GitHub (Note: User need to sign in before posting)
  def signed_in?
    current_user.present?
  end

end
