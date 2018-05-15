class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_path
    end
  end
  
  def counts(user)
    @count_groups = groups.count
  end
  
end
