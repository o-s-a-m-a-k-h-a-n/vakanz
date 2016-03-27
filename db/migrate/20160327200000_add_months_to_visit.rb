class AddMonthsToVisit < ActiveRecord::Migration
  def change
    create_table :ideal_months do |t|
      t.references :cities
      t.references :months
      t.timestamps
    end
  end
end
