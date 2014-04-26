class CreatePromotionals < ActiveRecord::Migration
  def change
    create_table :promotionals do |t|
      t.text :html
      t.integer :test_email_count, :default => 0
      t.integer :qa_email_count, :default => 0
      t.text :missing_images
      t.references :campaign
      t.attachment :folder
      t.timestamps
    end
  end
end
