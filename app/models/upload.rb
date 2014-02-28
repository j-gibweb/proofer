# the idea here is to have the Uplaod class belong to promotionals , transactionals , xsl_modules , users and campaigns - instead of the rampant code re-use I have going on now.
class Upload < ActiveRecord::Base
  attr_accessible :folder

  has_attached_file :folder ,
	:url  => "/assets/:id/:basename.:extension",
	:path => ":rails_root/public/assets/:id/:basename.:extension" 

end
