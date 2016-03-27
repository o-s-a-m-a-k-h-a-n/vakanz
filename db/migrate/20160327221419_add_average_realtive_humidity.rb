class AddAverageRealtiveHumidity < ActiveRecord::Migration
  def change
    create_table :average_relative_humidities do |t|
      t.references :cities
      t.references :months
      t.integer :percent
      t.timestamps
    end
  end
end
