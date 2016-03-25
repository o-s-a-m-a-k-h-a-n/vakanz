class AddPhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :cities
      t.string :source
      t.string :flickr_id
      t.string :owner
      t.string :secret
      t.string :server
      t.integer :farm
      t.string :title
      t.integer :ispublic
      t.integer :isfriend
      t.integer :isfamily
    end
  end
end
