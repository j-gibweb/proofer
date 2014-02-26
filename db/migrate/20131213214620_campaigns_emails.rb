class CampaignsEmails < ActiveRecord::Migration
  def up
  	create_table :campaigns_emails, :id => false do |t|
  		t.integer :campaign_id
  		t.integer :email_id
  	end
  	add_index :campaigns_emails , [:campaign_id, :email_id]
  end

  def down
  	drop_table :campaigns_emails
  end
end
