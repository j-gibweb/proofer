class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user! , :except => [:receive_email]

  def admin_user!
    redirect_to root_url unless current_user && current_user.is_admin?
  end  
  
  def unique_s3_name object 
  	"#{object.class}_#{object.created_at}".gsub!(/:/,"").gsub!(/ /,"_").gsub!(/-/,"_").downcase
  end

end
