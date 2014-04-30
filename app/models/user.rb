class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me , :is_admin , :name , :confirmed_user, :office
  
  validates_presence_of :name, :email 

  has_and_belongs_to_many :campaigns 
  has_and_belongs_to_many :recipient_lists

  def email_user_notification notification
    # better to have - when / case statement here, for notifications of different shit.
    if notification == :confirmed_user
      SES::EmailHandler.send_email(
        :from_app => true,
        :recipients => "#{self.email}",
        :from => "\"Proofer-Mailer\" <j.gibweb@gmail.com>",
        :subject => "You're In!",
        :html => "Congrats, you're approved to use proofer-mailer now... Go get em tiger."
        )
    end

  end

end
