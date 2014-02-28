class CreateXslModules < ActiveRecord::Migration
  def change
    create_table :xsl_modules do |t|
      t.text :xsl
      t.integer :order
      t.references :transactional
      t.attachment :folder
      t.timestamps
    end
  end
end
