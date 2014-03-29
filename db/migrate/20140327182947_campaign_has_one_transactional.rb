class CampaignHasOneTransactional < ActiveRecord::Migration
  def up
  	change_table :transactionals do |t|
  		t.references :campaign
  	end
  end

  def down
  end
end
