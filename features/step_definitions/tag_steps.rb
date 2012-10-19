Given "there are tags applied to the latest article" do
  @foo = Fabricate :tag, name: "Foo"
  @bar = Fabricate :tag, name: "Bar"
  @baz = Fabricate :tag, name: "Baz"

  @article_latest.tags = [ @foo, @bar, @baz ]
end

And "the first tag is also applied to the next-to-last article" do
  @article_next_to_last.tags = [ @foo ]
end

And "I select that tag in the list of tags" do
  within "#single-article .article .tags" do
    click_link "Foo"
  end
end

Then "I should see both the latest and next-to-last articles on the tag page" do
  within ".tags" do
    should have_content "Artikelen getagged met 'Foo':"

    within "#tagged-articles" do
      within ".article:first" do
        should have_selector ".title h2", text: "Latest article"
        should have_selector ".title .read-more", text: "Lees verder"
      end

      within ".article:last" do
        should have_selector ".title h2", text: "Next to last article"
        should have_selector ".title .read-more", text: "Lees verder"
      end
    end
  end
end

When "I go back to the latest article" do
  visit article_path(@article_latest)
end

And "I select another tag from the list of tags" do
  within "#single-article .article .tags" do
    click_link "Bar"
  end
end

Then "I should only see the latest article on the tag page" do
  within ".tags" do
    should have_content "Artikelen getagged met 'Bar':"

    within "#tagged-articles" do
      within ".article:first" do
        should have_selector ".title h2", text: "Latest article"
        should have_selector ".title .read-more", text: "Lees verder"
      end

      should have_no_selector ".title h2", text: "Next to last article"
    end
  end
end
