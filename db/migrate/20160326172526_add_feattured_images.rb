class AddFeatturedImages < ActiveRecord::Migration
  def change
    create_table :featured_images do |t|
      t.references :cities
      t.string :px250
      t.string :px500
      t.string :px1000
      t.string :px1500
      t.timestamps
    end
  end
end
