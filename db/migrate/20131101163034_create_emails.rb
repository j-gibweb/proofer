class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :subject
      t.text :recipients
      t.text :markup
      t.string :campaign_name
      t.string :status , :default => "Testing"

      t.timestamps
    end
  end
end
