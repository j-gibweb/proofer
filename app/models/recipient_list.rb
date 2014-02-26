class RecipientList < ActiveRecord::Base
  attr_accessible :list, :name , :all_users , :preferred
  # serialize :list 

  has_and_belongs_to_many :users


  def make_so_only_one_list_is_preferred(user)
  	user.recipient_lists.each do |list|
  		list.preferred = false
  		list.save
  	end
  end

end
