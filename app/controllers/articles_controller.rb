class ArticlesController < ApplicationController

  def show
    @article  = Article.published.friendly.find(params[:id])
    @articles = Article.published_without(@article)
  end

end
