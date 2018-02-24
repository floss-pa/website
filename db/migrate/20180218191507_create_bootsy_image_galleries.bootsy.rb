class CreateBootsyImageGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :bootsy_image_galleries do |t|
      t.references :bootsy_resource, polymorphic: true, index: {name: "bootsy_res_image_gal"}
      t.timestamps
    end
  end
end
