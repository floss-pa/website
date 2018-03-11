class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :event, foreign_key: true
      t.integer :amount
      t.references :ticket_type, foreign_key: true
      t.string :token, limit: 50, index: {unique: true}

      t.timestamps
    end
  end
end
