class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user! 

  
  def admin_user!
    redirect_to root_url unless current_user && current_user.is_admin?
  end  

end
