class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user! , :except => [:receive_email]
  
  # before_filter :confirmed_user!



  # This will be a set of dynamic values -> controlled by User.is_admin 
  # before_filter :get_destination_emails 

  def admin_user!
    redirect_to root_url unless current_user && current_user.is_admin?
  end  


  # def confirmed_user!
  #   unless current_user && current_user.confirmed_user?
  #     return false
  #   end
  # end



  # def get_user
  #   if current_user
  #     # @user = User.find(current_user.id)
  #     # @current_user = User.find(current_user.id)
  #   end
  # end


  # def get_destination_emails
  #   if current_user
  #     current_user_lists = current_user.recipient_lists
  #     all_users_lists = RecipientList.where("all_users = ?" , true)
  #     @recipient_lists  = current_user_lists | all_users_lists
  #   end
  # end

end
