class AddCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.references :cities
      t.decimal :airbnb_median
      t.decimal :airbnb_vs_apartment_price_ratio
      t.decimal :beer_in_cafe
      t.decimal :coffee_in_cafe
      t.decimal :hotel
      t.decimal :non_alcoholic_drink_in_cafe #coca cola
      t.decimal :flights
      t.timestamps
    end
  end
end
