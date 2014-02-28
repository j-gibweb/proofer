class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
    	t.attachment :folder
    	t.references :transactional
    	t.references :xml_module
    	t.references :promotional
    	t.references :email
      t.timestamps
    end
  end
end
