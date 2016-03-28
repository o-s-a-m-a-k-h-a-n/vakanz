class ChangeTemperatureColumnTypes < ActiveRecord::Migration
  def change
    change_column :average_low_temperatures, :temperature, :float
    change_column :daily_mean_temperatures, :temperature, :float
    change_column :average_high_temperatures, :temperature, :float
  end
end
