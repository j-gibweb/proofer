class AddAttachmentFolderToEmails < ActiveRecord::Migration
  def self.up
    change_table :emails do |t|
      t.attachment :folder
    end
  end

  def self.down
    drop_attached_file :emails, :folder
  end
end
