class AddAverageRainyDays < ActiveRecord::Migration
  def change
    create_table :average_rainy_days do |t|
      t.references :cities
      t.references :months
      t.integer :count
      t.timestamps
    end
  end
end
