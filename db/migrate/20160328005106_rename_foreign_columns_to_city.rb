class RenameForeignColumnsToCity < ActiveRecord::Migration
  def change
    rename_column :average_high_temperatures, :cities_id, :city_id
    rename_column :average_low_temperatures, :cities_id, :city_id
    rename_column :daily_mean_temperatures, :cities_id, :city_id
    rename_column :average_rainy_days, :cities_id, :city_id
    rename_column :average_relative_humidities, :cities_id, :city_id
    rename_column :costs, :cities_id, :city_id
    rename_column :featured_images, :cities_id, :city_id
    rename_column :ideal_months, :cities_id, :city_id
    rename_column :photos, :cities_id, :city_id
    rename_column :scores, :cities_id, :city_id

    rename_column :average_high_temperatures, :months_id, :month_id
    rename_column :average_low_temperatures, :months_id, :month_id
    rename_column :daily_mean_temperatures, :months_id, :month_id
    rename_column :average_rainy_days, :months_id, :month_id
    rename_column :average_relative_humidities, :months_id, :month_id
    rename_column :ideal_months, :months_id, :month_id
  end
end
