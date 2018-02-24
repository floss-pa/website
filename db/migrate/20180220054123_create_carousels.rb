class CreateCarousels < ActiveRecord::Migration[5.1]
  def change
    create_table :carousels do |t|
      t.references :user, foreign_key: true
      t.string :header
      t.string :sentence
      t.string :link
      t.string :image
      t.references :page, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
