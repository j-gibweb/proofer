class XslModule < ActiveRecord::Base
  attr_accessible :order, :transactional, :xsl , :xslt
  belongs_to :transactional

  def generate_xslt xsl_module
    doc = Nokogiri::XML(xsl_module.transactional.xml)
    if xsl_module.xsl.include? "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
      xslt = Nokogiri::XSLT(xsl_module.xsl)  
      xslt.transform(doc).to_xml 
    else # its likely just a simple html module
      xsl_module.xsl
    end
  end
  
end
