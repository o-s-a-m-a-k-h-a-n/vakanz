class AddMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.string :name
    end
  end
end
