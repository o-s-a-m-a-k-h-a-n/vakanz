class AddAttributesToCities < ActiveRecord::Migration
  def change
    add_column :cities, :country, :string
    add_column :cities, :region, :string
    add_column :cities, :internet_download_speed, :string
  end
end
