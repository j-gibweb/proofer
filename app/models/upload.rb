class Upload < ActiveRecord::Base
  # attr_accessible :folder

  has_attached_file :folder ,
	:url  => "/assets/:id/:basename.:extension",
	:path => ":rails_root/public/assets/:id/:basename.:extension" 
	
end
