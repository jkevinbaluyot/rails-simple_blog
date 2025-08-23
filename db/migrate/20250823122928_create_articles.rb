class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content_html
      t.string :slug, index: true
      t.string :meta_title
      t.text :meta_description
      t.string :meta_keywords
      t.datetime :published_at, index: true

      t.timestamps
    end
  end
end
