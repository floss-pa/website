class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :image
      t.string :location
      t.string :frecuency
      t.datetime :start_at
      t.datetime :end_at
      t.text :description
      t.string :keyworkds
      t.string :ticket_url
      t.references :community, foreign_key: true
      t.string :organizer
      t.boolean :publish

      t.timestamps
    end
  end
end
