class AddLinkTimestampsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :link, :string
    add_column :photos, :created_at, :datetime
    add_column :photos, :updated_at, :datetime
  end
end
