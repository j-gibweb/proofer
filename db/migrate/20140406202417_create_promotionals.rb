class CreatePromotionals < ActiveRecord::Migration
  def change
    create_table :promotionals do |t|
      t.text :html
      t.references :campaign
      
      t.timestamps
    end
  end
end
