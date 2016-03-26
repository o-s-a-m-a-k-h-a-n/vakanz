class RemoveColumnsFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :source, :string
    remove_column :photos, :flickr_id, :string
    remove_column :photos, :owner, :string
    remove_column :photos, :secret, :string
    remove_column :photos, :server, :string
    remove_column :photos, :farm, :string
    remove_column :photos, :ispublic, :string
    remove_column :photos, :isfriend, :string
    remove_column :photos, :isfamily, :string
  end
end
