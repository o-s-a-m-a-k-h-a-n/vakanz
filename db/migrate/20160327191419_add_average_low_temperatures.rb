class AddAverageLowTemperatures < ActiveRecord::Migration
  def change
    create_table :average_low_temperatures do |t|
      t.references :cities
      t.references :months
      t.decimal :temperature
      t.timestamps
    end
  end
end
