class AddHtmlFileNameToEmailModel < ActiveRecord::Migration
  def change
  	change_table :emails do |t|
  		t.string :html_file_name , :default => ""
  	end
  end
end
