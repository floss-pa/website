class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :keywords
      t.string :language, limit: 2
      t.boolean :publish
      t.datetime :published_at

      t.timestamps
    end
  end
end
