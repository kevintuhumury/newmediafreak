module TagHelper

  def tags_for(article)
    sorted_tags_for(article).map(&:name).to_sentence
  end

  private

  def sorted_tags_for(article)
    article.tags.sort { |a, b| b.frequency <=> a.frequency }
  end

end
