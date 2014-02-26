class DeleteUnconfirmedUserFieldToUserModelForPatch < ActiveRecord::Migration
  def up
  	remove_column :users , :confirmed_user
  end

  def down
  end
end
