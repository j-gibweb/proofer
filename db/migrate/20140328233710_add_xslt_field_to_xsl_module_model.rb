class AddXsltFieldToXslModuleModel < ActiveRecord::Migration
  def change
  	change_table :xsl_modules do |t|
  		t.text :xslt
  	end
  end
end
