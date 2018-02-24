class CreateBootsyImages < ActiveRecord::Migration[5.1]
  def change
    create_table :bootsy_images do |t|
      t.string :image_file
      t.references :image_gallery, index: {name: "bootsy_img_gallery"}
      t.timestamps
    end
  end
end
