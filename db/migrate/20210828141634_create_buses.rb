class CreateBuses < ActiveRecord::Migration[6.1]
  def change
    create_table :buses do |t|
      t.integer :seats, default: 49, null: false

      t.timestamps
    end
  end
end
