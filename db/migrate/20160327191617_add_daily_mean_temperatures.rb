class AddDailyMeanTemperatures < ActiveRecord::Migration
  def change
    create_table :daily_mean_temperatures do |t|
      t.references :cities
      t.references :months
      t.decimal :temperature
      t.timestamps
    end
  end
end
