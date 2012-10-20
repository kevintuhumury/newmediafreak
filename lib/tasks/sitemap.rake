namespace :sitemap do

  desc "Build sitemap.xml"
  task build: :environment do
    Sitemap.build!
  end

end
