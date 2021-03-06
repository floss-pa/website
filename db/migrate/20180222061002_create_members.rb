class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.references :community, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :admin

      t.timestamps
    end
  end
end
