class ArticlesController < ApplicationController

  def index
    @articles = Article.published
  end

  def show
    @article  = Article.published.friendly.find(params[:id])
    @articles = Article.published_without(@article)
  end

end
