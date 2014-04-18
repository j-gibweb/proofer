class Promotional < ActiveRecord::Base
  attr_accessible :html , :folder 
  has_one :upload

    has_attached_file :folder ,
    :url  => "/assets/:id/:basename.:extension",
    :path => ":rails_root/public/assets/promotionals/:id/:basename.:extension" 
    validates_attachment_content_type :folder , :content_type => ["application/zip" , "text/html" , "text/htm"]

end
