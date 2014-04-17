class Campaign < ActiveRecord::Base
  attr_accessible :name, :status , :client_name
  has_and_belongs_to_many :users
  has_and_belongs_to_many :emails
  has_one :transactional
  has_one :promotional

  def self.most_recent
    order("updated_at desc")
  end
	
end
