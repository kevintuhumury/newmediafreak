class TagsController < ApplicationController

  def show
    @articles        = Article.published
    @tagged_articles = @articles.tagged_with(tag)
  end

  private

  def tag
    @tag ||= Tag.find(params[:id])
  end

end
