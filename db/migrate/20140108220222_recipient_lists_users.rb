class RecipientListsUsers < ActiveRecord::Migration
  def up
  	create_table :recipient_lists_users, :id => false do |t|
  		t.integer :recipient_list_id
  		t.integer :user_id
  	end
  	add_index :recipient_lists_users , [:recipient_list_id, :user_id]
  end

  def down
  	drop_table :recipient_lists_users
  end
end
