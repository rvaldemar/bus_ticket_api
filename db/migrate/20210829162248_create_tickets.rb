class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.references :route, null: false, foreign_key: true
      t.jsonb :payment_details, null: false
      t.string :status, null: false
      t.integer :seat_number, null: false

      t.timestamps
    end
  end
end
