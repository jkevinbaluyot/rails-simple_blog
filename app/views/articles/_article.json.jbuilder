json.extract! article, :id, :title, :content_html, :slug, :meta_title, :meta_description, :meta_keywords, :published_at, :created_at, :updated_at
json.url article_url(article, format: :json)
