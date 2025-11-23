class HomeController < ApplicationController
  def index
    @articles = if current_user.present?
      Article.with_category.with_tags.published
    else
      Article.with_category.with_tags.all
    end
  end

  def archive
  end
end
