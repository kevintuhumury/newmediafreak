module TagHelper

  def tags_for(article)
    linked_tags_for(article).to_sentence.html_safe
  end

  private

  def linked_tags_for(article)
    sorted_tags_for(article).map { |tag| link_to tag.name, tag_url(tag) }
  end

  def sorted_tags_for(article)
    article.tags.sort { |a, b| b.frequency <=> a.frequency }
  end

end
