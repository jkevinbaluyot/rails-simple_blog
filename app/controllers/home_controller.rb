class HomeController < ApplicationController
  def index
    @articles = if current_user.present?
      Article.published
    else
      Article.all
    end
  end

  def archive
  end
end
