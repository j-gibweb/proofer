class AddAdditionalRecipientsToEmails < ActiveRecord::Migration
  def change
  	change_table :emails do |t|
  		t.text :additional_recipients , :default => ""
  	end
  end
end
