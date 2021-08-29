class CreateRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :routes do |t|
      t.references :bus, null: false, foreign_key: true
      t.references :start, null: false, foreign_key: { to_table: 'cities' }
      t.references :destination, null: false, foreign_key: { to_table: 'cities' }
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end
  end
end
