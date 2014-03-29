class CreateTransactionals < ActiveRecord::Migration
  def change
    create_table :transactionals do |t|
      t.text :xml
      t.text :shell

      t.timestamps
    end
  end
end
