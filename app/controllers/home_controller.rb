class HomeController < ApplicationController
  def index
    @limit = 10

    @category_id = params[:category_id]
    @tag_id = params[:tag_id]
    article_query = if current_user.present?
      Article.with_category.with_tags.by_published_at
    else
       Article.with_category.with_tags.by_published_at.published
    end

    articles = if @category_id.present?
      article_query.where(category_id: @category_id)
    elsif @tag_id.present?
      article_query.joins(:tags)
                  .where(tags: { id: @tag_id })
    else
      article_query
    end

    @pagy, @articles = pagy(articles, limit: @limit)
  end

  def archive
    @current_year = if params[:year].present?
      params[:year].to_i
    else
      Time.now.year
    end
    @years = Article.get_years

    @articles = Article.by_year(@current_year).published
  end
end
