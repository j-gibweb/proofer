class CreateRecipientLists < ActiveRecord::Migration
  def change
    create_table :recipient_lists do |t|
      t.string :name
      t.text :list
      t.string :office
      t.string :purpose
      t.boolean :all_users , :default => false	
      t.boolean :preferred , :default => false

      t.timestamps
    end
  end
end
