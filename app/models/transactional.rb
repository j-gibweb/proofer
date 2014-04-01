class Transactional < ActiveRecord::Base

  attr_accessible :shell, :xml , :folder
  has_many :xsl_modules
  has_one :upload

  has_attached_file :folder ,
	:url  => "/assets/:id/:basename.:extension",
	:path => ":rails_root/public/assets/transactionals/:id/:basename.:extension" 

	validates_attachment_content_type :folder , :content_type => ["application/zip" , "text/html" , "text/htm"]

	def handle_ri_module_requests_in_html
	  @modules = self.shell.scan(/\$(.*?)\$/m).flatten
	  @modules.each_with_index do |mod , i|
	    if !mod.include? "document"
	      @modules[i] = nil
	    end
	  end
	  self.replace_ri_modules_with_xsl_modules(@modules.compact!)
	end

	def replace_ri_modules_with_xsl_modules modules
	  modules.each_with_index do |mod , i|
	    i+=1 # because computers index from zero, and my co-workers dont.
	    self.shell.sub!(mod , i.to_s) 
	  end
	  self.xsl_modules.each do |xsl_mod|
	    self.shell.sub!(/\$#{xsl_mod.order.to_s}\$/, xsl_mod.xslt) if xsl_mod.xslt
	  end
	end

end
