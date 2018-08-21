class TagsController < ApplicationController

  def show
    @articles        = Article.published.to_a
    @tagged_articles = Article.published.tagged_with(tag)
  end

  private

  def tag
    @tag ||= Tag.friendly.find(params[:id])
  end

end
