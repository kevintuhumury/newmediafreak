Given "there are articles" do
  @article_first  = Fabricate :article, title: "First article"
  @article_second = Fabricate :article, title: "Second article"
end

When "I visit the homepage" do
  visit root_path
end

Then "I should see the latest articles" do
  within "#content .articles" do
    page.should have_selector ".article h2", text: "First article"
    page.should have_selector ".article h2", text: "Second article"
  end
end

When "I select the latest article" do
  pending # express the regexp above with the code you wish you had
end

Then "I should see the full article" do
  pending # express the regexp above with the code you wish you had
end

Given "there are more articles than the latest articles" do
  pending # express the regexp above with the code you wish you had
end

Then "I should see the other articles in the carousel" do
  pending # express the regexp above with the code you wish you had
end
