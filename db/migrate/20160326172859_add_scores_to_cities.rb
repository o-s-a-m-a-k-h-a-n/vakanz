class AddScoresToCities < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :cities
      t.decimal :nightlife
      t.decimal :safety
      t.decimal :free_wifi_available
      t.decimal :nightlife
      t.timestamps
    end
  end
end
