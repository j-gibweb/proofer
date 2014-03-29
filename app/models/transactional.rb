class Transactional < ActiveRecord::Base
  attr_accessible :shell, :xml 
  has_many :xsl_modules
  has_one :upload
end
