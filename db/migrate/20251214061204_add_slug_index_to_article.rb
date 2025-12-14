class AddSlugIndexToArticle < ActiveRecord::Migration[7.2]
  def change
    remove_index :articles, :slug
    add_index :articles, :slug, unique: true
  end
end
