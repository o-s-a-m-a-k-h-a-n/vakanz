class RemoveFlightsFromCosts < ActiveRecord::Migration
  def change
    remove_column :costs, :flights, :decimal
  end
end
