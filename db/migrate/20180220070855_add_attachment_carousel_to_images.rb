class AddAttachmentCarouselToImages < ActiveRecord::Migration[4.2]
  def self.up
    change_table :carousels do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :carousel, :image
  end
end
