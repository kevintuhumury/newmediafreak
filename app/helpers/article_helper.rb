module ArticleHelper

  def find_pages_for(articles)
    (articles.size.to_f / number_of_articles_per_page).ceil
  end

  def number_of_filler_elements_for(articles)
    if articles.size > number_of_articles_per_page
      number_of_articles_per_page - (articles.size % number_of_articles_per_page)
    else
      number_of_articles_per_page - articles.size
    end
  end

  private

  def number_of_articles_per_page
    6
  end

end
