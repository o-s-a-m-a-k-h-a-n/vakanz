class AddWikiSlugToCities < ActiveRecord::Migration
  def change
    add_column :cities, :wiki_slug, :string
  end
end
