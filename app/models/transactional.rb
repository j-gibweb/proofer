class Transactional < ActiveRecord::Base

  attr_accessible :shell, :xml , :folder
  has_many :xsl_modules
  has_one :upload

  has_attached_file :folder ,
	:url  => "/assets/:id/:basename.:extension",
	:path => ":rails_root/public/assets/transactionals/:id/:basename.:extension" 

	validates_attachment_content_type :folder , :content_type => ["application/zip" , "text/html" , "text/htm"]

end
