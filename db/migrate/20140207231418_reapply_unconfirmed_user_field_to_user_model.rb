class ReapplyUnconfirmedUserFieldToUserModel < ActiveRecord::Migration
  def up
  	change_table :users do |t|
  		t.boolean :confirmed_user , :default => false
  	end
  end

  def down
  end
end
