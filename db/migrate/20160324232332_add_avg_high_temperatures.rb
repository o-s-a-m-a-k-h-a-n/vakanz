class AddAvgHighTemperatures < ActiveRecord::Migration
  def change
    create_table :average_high_temperatures do |t|
      t.references :cities
      t.references :months
      t.decimal :temperature
      t.timestamps
    end
  end
end
