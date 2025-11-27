class HomeController < ApplicationController
  def index
    @pagy, @articles = pagy(Article.with_category.with_tags.published.by_published_at, limit: 1)
  end

  def archive
  end
end
