class CampaignsUsers < ActiveRecord::Migration
  def up
  	create_table :campaigns_users, :id => false do |t|
  		t.integer :campaign_id
  		t.integer :user_id
  	end
  	add_index :campaigns_users , [:campaign_id, :user_id]
  end

  def down
  	drop_table :campaigns_users
  end
end

