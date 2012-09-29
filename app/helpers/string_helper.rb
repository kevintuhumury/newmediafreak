module StringHelper

  def shorten(description)
    truncate(strip_tags(description), length: 400).squish
  end

end
