Given "I am on the homepage" do
  visit root_path
end

Then "I should see the page title" do
  title = "New Media Freak - Weblog van Kevin Tuhumury"

  within "head" do
    should have_xpath "//title[contains(.,'#{title}')]"
  end

  within "header" do
    should have_selector "h1", text: title
  end
end

Then "I should find out which pages are visitable" do
  within "nav ul" do
    should have_selector "li", text: "Home"
    should have_selector "li", text: "Fotografie"
  end
end

Then "I should be pointed to the website sections or social media" do
  within "#descriptive-navigation" do
    should have_selector "h3", text: "Ben je op zoek naar iets? Zoals mijn artikelen, foto's of apps? Of ben je op zoek naar mijn social media, zoals twitter, flickr, facebook of github?"
  end
end

Then "I should see a copyright notice" do
  within "footer" do
    should have_selector "p", text: "Copyright 2002 - #{Date.today.year}, Kevin Tuhumury. Alle rechten voorbehouden. Onderdeel van het THMRY netwerk."
  end
end

Then "I should be able to go up, up and away..." do
  within "footer" do
    should have_selector "#to-top", text: "Up, up and away"
  end
end
