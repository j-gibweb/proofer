class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me , :is_admin , :name , :confirmed_user
  
  validates_presence_of :name, :email 

  has_and_belongs_to_many :campaigns 
  has_and_belongs_to_many :recipient_lists
end
