Given "there are articles" do
  @article_one          = Fabricate :article, title: "First article", created_at: 7.days.ago
  @article_two          = Fabricate :article, title: "Second article", created_at: 6.days.ago
  @article_three        = Fabricate :article, title: "Third article", created_at: 5.days.ago
  @article_next_to_last = Fabricate :article, title: "Next to last article", created_at: 4.days.ago
  @article_latest       = Fabricate :article, title: "Latest article", created_at: 3.days.ago
end

When "I visit the homepage" do
  visit root_path
end

Then "I should see the latest articles" do
  within "#content .articles" do
    within "#latest-article" do
      page.should have_selector ".title h2", text: "Latest article"
      page.should have_selector ".info .read-more", text: "Lees verder"
    end

    within "#next-to-last-articles" do
      page.should have_selector ".title h2", text: "Next to last article"
      page.should have_selector ".title h2", text: "Third article"
      page.should have_selector ".title .read-more", text: "Lees verder", count: 2
    end
  end
end

When "I select the latest article" do
  pending
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
