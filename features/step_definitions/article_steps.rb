Given "there are articles" do
  @article_first        = Fabricate :article, id: 1, title: "First article", created_at: 4.days.ago, content: "Content for the first article."
  @article_second       = Fabricate :article, id: 2, title: "Second article", created_at: 3.days.ago, content: "Content for the second article."
  @article_next_to_last = Fabricate :article, id: 3, title: "Next to last article", created_at: 2.days.ago, content: "Content for the next-to-last article."
  @article_latest       = Fabricate :article, id: 4, title: "Latest article", created_at: 1.days.ago, content: "Content for the latest article."
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
      page.should have_selector ".title h2", text: "Second article"
      page.should have_selector ".title .read-more", text: "Lees verder", count: 2
    end
  end
end

When "I select the latest article" do
  within "#content .articles #latest-article" do
    find(".info .read-more a").click
  end
end

When "I select the next-to-last article" do
  within "#content .articles #next-to-last-articles" do
    find(".title .read-more a").click
  end
end

Then "I should see the full latest article" do
  within "#content #single-article" do
    within ".article" do
      page.should have_selector ".title h2", text: "Latest article"
      page.should have_selector ".content", text: "Content for the latest article."
    end

    within ".navigation" do
      page.should have_selector "ul li.prev a span.button", text: "vorig artikel"
      page.should have_selector "ul li.prev a span.title", text: "Next to last article"

      page.should have_no_selector "ul li.upcoming a span.button"
      page.should have_no_selector "ul li.upcoming a span.title"
    end
  end
end

Then "I should see the full next-to-last article" do
  within "#content #single-article" do
    within ".article" do
      page.should have_selector ".title h2", text: "Next to last article"
      page.should have_selector ".content", text: "Content for the next-to-last article."
    end

    within ".navigation" do
      page.should have_selector "ul li.prev a span.button", text: "vorig artikel"
      page.should have_selector "ul li.prev a span.title", text: "Second article"

      page.should have_selector "ul li.upcoming a span.button", text: "volgend artikel"
      page.should have_selector "ul li.upcoming a span.title", text: "Latest article"
    end
  end
end

When "I navigate to the next-to-last article" do
  within "#content #single-article .navigation" do
    find("ul li.prev a").click
  end
end

When "I navigate to the first article" do
  within "#content #single-article .navigation" do
    find("ul li.prev a").click
  end

  within "#content #single-article" do
    within ".article" do
      page.should have_selector ".title h2", text: "Second article"
    end

    within ".navigation" do
      find("ul li.prev a").click
    end
  end
end

Then "I should only be able to navigate forward" do
  within "#content #single-article" do
    within ".article" do
      page.should have_selector ".title h2", text: "First article"
      page.should have_selector ".content", text: "Content for the first article."
    end

    within ".navigation" do
      page.should have_no_selector "ul li.prev a span.button"
      page.should have_no_selector "ul li.prev a span.title"

      page.should have_selector "ul li.upcoming a span.button", text: "volgend artikel"
      page.should have_selector "ul li.upcoming a span.title", text: "Second article"

      find("ul li.upcoming a").click
    end
  end
end

Then "I should see the other articles in the carousel" do
  pending # express the regexp above with the code you wish you had
end
