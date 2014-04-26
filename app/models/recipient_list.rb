class RecipientList < ActiveRecord::Base
  attr_accessible :list, :name, :all_users, :preferred, :office, :purpose

  has_and_belongs_to_many :users

  def self.offices
    ["Seattle", "Chicago", "San Francisco", "New York"]
  end

  def self.purposes
    ["Testing", "QA"]
  end

  def self.get_recipient_emails_by_user(user)
    current_user_lists = user.recipient_lists
    all_users_lists = RecipientList.where("all_users = ?" , true)
    current_user_lists | all_users_lists 
  end

  def make_so_only_one_list_is_preferred(user)
    user.recipient_lists.each do |list|
      list.preferred = false
      list.save!
    end
  end

end
