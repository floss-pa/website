class CreateNewsContents < ActiveRecord::Migration[5.1]
  def change
    create_table :news_contents do |t|
      t.references :news, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
