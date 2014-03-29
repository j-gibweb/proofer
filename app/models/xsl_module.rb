class XslModule < ActiveRecord::Base
  attr_accessible :order, :transactional, :xsl , :xslt
  belongs_to :transactional
end
