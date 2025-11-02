class ArticleTag < ApplicationRecord
  self.table_name = "articles_tags"

  belongs_to :article
  belongs_to :tag
end
