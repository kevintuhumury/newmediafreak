class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :retrieve_articles

  private

  def retrieve_articles
    @articles = Article.published
  end
end
