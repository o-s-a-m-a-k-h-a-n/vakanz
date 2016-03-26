class AddFlickrSearchToCities < ActiveRecord::Migration
  def change
    add_column :cities, :flickr_tag, :string
    add_column :cities, :search_hits, :integer
  end
end
