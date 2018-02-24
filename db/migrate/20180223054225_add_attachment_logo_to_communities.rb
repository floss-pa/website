class AddAttachmentLogoToCommunities < ActiveRecord::Migration[4.2]
  def self.up
    change_table :communities do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :communities, :logo
  end
end
