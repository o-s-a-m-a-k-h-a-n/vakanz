class ChangeMonthIdInIdealmonths < ActiveRecord::Migration
  def change
    change_column :ideal_months, :month_id, :string
  end
end
