class Sitemap

  def self.build!
    new.sitemap.render_to Rails.root.join(Rails.application.secrets.sitemap_xml)
  end

  def sitemap
    XmlSitemap::Map.new(Rails.application.secrets.sitemap_site) do |sitemap|

      Article.all.each do |article|
        sitemap.add "artikel/#{article.slug}"
      end

      Tag.all.each do |tag|
        sitemap.add "tag/#{tag.slug}"
      end

    end
  end

end
