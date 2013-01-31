Given "there is an article" do
  @article = Fabricate :article, id: 100, title: "An article", created_at: 7.days.ago
end

Given "there are articles" do
  article_first         = Fabricate :article, id: 1, title: "First article", created_at: 4.days.ago, content: "Content for the first article."
  article_second        = Fabricate :article, id: 2, title: "Second article", created_at: 3.days.ago, content: "Content for the second article."
  @article_next_to_last = Fabricate :article, id: 3, title: "Next to last article", created_at: 2.days.ago, content: "Content for the next-to-last article."
  @article_latest       = Fabricate :article, id: 4, title: "Latest article", created_at: 1.day.ago, content: "Content for the latest article."
end

When "there are even more articles" do
  article_five  = Fabricate :article, id: 5, title: "Fifth article"
  article_six   = Fabricate :article, id: 6, title: "Sixth article"
  article_seven = Fabricate :article, id: 7, title: "Seventh article"
  article_eight = Fabricate :article, id: 8, title: "Eight article"
end

When "I visit the homepage" do
  visit root_path
end

When "I visit that article" do
  visit article_path(@article)
end

Then "I should see the latest articles" do
  within "#content .articles" do
    within "#latest-article" do
      should have_selector ".title h2", text: "Latest article"
      should have_selector ".info .read-more", text: "Lees verder"
    end

    within "#next-to-last-articles" do
      should have_selector ".title h2", text: "Next to last article"
      should have_selector ".title h2", text: "Second article"
      should have_selector ".title .read-more", text: "Lees verder", count: 2
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
    first(".title .read-more a").click
  end
end

Then "I should see the full latest article" do
  within "#content #single-article" do
    within ".article" do
      should have_selector ".title h2", text: "Latest article"
      should have_selector ".content", text: "Content for the latest article."
    end

    within ".navigation" do
      should have_selector "ul li.preceding a span.button", text: "vorig artikel"
      should have_selector "ul li.preceding a span.title", text: "Next to last article"

      should have_no_selector "ul li.succeeding a span.button"
      should have_no_selector "ul li.succeeding a span.title"
    end
  end
end

Then "I should see the full next-to-last article" do
  within "#content #single-article" do
    within ".article" do
      should have_selector ".title h2", text: "Next to last article"
      should have_selector ".content", text: "Content for the next-to-last article."
    end

    within ".navigation" do
      should have_selector "ul li.preceding a span.button", text: "vorig artikel"
      should have_selector "ul li.preceding a span.title", text: "Second article"

      should have_selector "ul li.succeeding a span.button", text: "volgend artikel"
      should have_selector "ul li.succeeding a span.title", text: "Latest article"
    end
  end
end

When "I navigate to the next-to-last article" do
  within "#content #single-article .navigation" do
    find("ul li.preceding a").click
  end
end

When "I navigate to the first article" do
  within "#content #single-article .navigation" do
    find("ul li.preceding a").click
  end

  within "#content #single-article" do
    within ".article" do
      should have_selector ".title h2", text: "Second article"
    end

    within ".navigation" do
      find("ul li.preceding a").click
    end
  end
end

Then "I should only be able to navigate forward" do
  within "#content #single-article" do
    within ".article" do
      should have_selector ".title h2", text: "First article"
      should have_selector ".content", text: "Content for the first article."
    end

    within ".navigation" do
      should have_no_selector "ul li.preceding a span.button"
      should have_no_selector "ul li.preceding a span.title"

      should have_selector "ul li.succeeding a span.button", text: "volgend artikel"
      should have_selector "ul li.succeeding a span.title", text: "Second article"

      find("ul li.succeeding a").click
    end
  end
end

Then "I should see the other articles in the carousel" do
  within "#carousel .items ul" do
    should have_selector "li a .bg-image"
    should have_selector "li a .title", text: "First article"

    should have_no_selector "li a .title", text: "Second article"
    should have_no_selector "li a .title", text: "Next to last article"
    should have_no_selector "li a .title", text: "Latest article"

    should have_selector "li .empty", count: 5

  end

  within "#carousel .navigation ul" do
    should have_selector "li span", count: 1
  end
end

Then "I should see multiple articles in the carousel" do
  within "#carousel .items ul" do
    should have_selector "li a .title", text: "First article"
    should have_selector "li a .title", text: "Second article"
    should have_selector "li a .title", text: "Next to last article"

    should have_no_selector "li a .title", text: "Latest article"

    should have_selector "li .empty", count: 3
  end

  within "#carousel .navigation ul" do
    should have_selector "li span", count: 1
  end
end

Then "I should see multiple pages in the carousel" do
  within "#carousel .items ul" do
    should have_selector "li a .title", text: "First article"
    should have_selector "li a .title", text: "Second article"
    should have_selector "li a .title", text: "Next to last article"
    should have_selector "li a .title", text: "Fifth article"
    should have_selector "li a .title", text: "Sixth article"
    should have_selector "li a .title", text: "Seventh article"
    should have_selector "li a .title", text: "Eight article"

    should have_no_selector "li a .title", text: "Latest article"

    should have_selector "li .empty", count: 5
  end

  within "#carousel .navigation ul" do
    should have_selector "li span", count: 2
  end
end

Given "there is an unpublished article" do
  @unpublished = Fabricate :article, id: 5, title: "Unpublished article", created_at: Date.today, published: false
end

When "I visit the unpublished article" do
  visit article_path(@unpublished)
end

Then "I should see a 404 error page" do
  step "I should see a custom 404 error page"
end

Then "I should not see the unpublished article on the homepage" do
  within "#content .articles #latest-article" do
    should have_no_selector ".title h2", text: "Nieuw: Unpublished article"
    should have_selector ".title h2", text: "Nieuw: Latest article"
  end
end

When "the unpublished article is published" do
  @unpublished.published = true
  @unpublished.save!
end

When "I refresh the page" do
  visit root_path
end

Then "I should see the previously unpublished article on the homepage" do
  within "#content .articles #latest-article" do
    should have_selector ".title h2", text: "Nieuw: Unpublished article"
    should have_no_selector ".title h2", text: "Nieuw: Latest article"
  end
end

Then "I should see the full latest article with tags" do
  step "I should see the full latest article"

  within "#single-article .article .tags" do
    should have_content "Foo, Bar en Baz"
  end
end
