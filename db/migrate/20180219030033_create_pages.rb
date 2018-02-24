class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :language
      t.string :keywords
      t.text :content
      t.boolean :carousel
      t.boolean :is_publish
      t.boolean :in_menu
      t.string :menu_label
      t.boolean :is_home

      t.timestamps
    end
  end
end
