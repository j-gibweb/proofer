class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :client_name
      t.string :status , :default => "Testing"

      t.timestamps
    end
  end
end
