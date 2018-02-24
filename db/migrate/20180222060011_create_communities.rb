class CreateCommunities < ActiveRecord::Migration[5.1]
  def change
    create_table :communities do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.text :information
      t.string :logo
      t.string :site

      t.timestamps
    end
  end
end
