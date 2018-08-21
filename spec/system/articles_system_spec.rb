require 'rails_helper'

RSpec.describe 'Articles', type: :system do

  let!(:first_article)        { Fabricate :article, id: 1, title: 'First article', created_at: 4.days.ago, content: 'Content for the first article.' }
  let!(:second_article)       { Fabricate :article, id: 2, title: 'Second article', created_at: 3.days.ago, content: 'Content for the second article.' }
  let!(:next_to_last_article) { Fabricate :article, id: 3, title: 'Next to last article', created_at: 2.days.ago, content: 'Content for the next-to-last article.' }
  let!(:latest_article)       { Fabricate :article, id: 4, title: 'Latest article', created_at: 1.day.ago, content: 'Content for the latest article.' }

  let!(:tag_1) { Fabricate :tag, name: 'Tag 1' }
  let!(:tag_2) { Fabricate :tag, name: 'Tag 2' }
  let!(:tag_3) { Fabricate :tag, name: 'Tag 3' }

  it 'shows the latest articles' do
    visit root_url

    within '#content .articles' do
      within '#latest-article' do
        expect(page).to have_selector '.title h2', text: 'Latest article'
        expect(page).to have_selector '.info .read-more', text: 'Lees verder'
      end

      within '#next-to-last-articles' do
        expect(page).to have_selector '.title h2', text: 'Next to last article'
        expect(page).to have_selector '.title h2', text: 'Second article'
        expect(page).to have_selector '.title .read-more', text: 'Lees verder', count: 2
      end
    end
  end

  it 'shows the latest article' do
    visit root_url
    visit_the_latest_article

    view_the_latest_article
  end

  it 'shows the next-to-last article' do
    visit root_url

    within '#content .articles #next-to-last-articles' do
      first('.title .read-more a').click
    end

    view_the_next_to_last_article
  end

  it 'navigates between articles' do
    visit root_url
    visit_the_latest_article

    view_the_latest_article

    # navigate to the next-to-last article

    within '#content #single-article .navigation' do
      find('ul li.preceding a').click
    end

    view_the_next_to_last_article

    # navigate to the first article

    within '#content #single-article .navigation' do
      find('ul li.preceding a').click
    end

    within '#content #single-article' do
      within '.article' do
        expect(page).to have_selector '.title h2', text: 'Second article'
      end

      within '.navigation' do
        find('ul li.preceding a').click
      end
    end

    # only navigate forward

    within '#content #single-article' do
      within '.article' do
        expect(page).to have_selector '.title h2', text: 'First article'
        expect(page).to have_selector '.content', text: 'Content for the first article.'
      end

      within '.navigation' do
        expect(page).to have_no_selector 'ul li.preceding a span.button'
        expect(page).to have_no_selector 'ul li.preceding a span.title'

        expect(page).to have_selector 'ul li.succeeding a span.button', text: 'volgend artikel'
        expect(page).to have_selector 'ul li.succeeding a span.title', text: 'Second article'

        find('ul li.succeeding a').click
      end
    end
  end

  it 'shows an article in the carousel' do
    visit root_url

    within '#content .articles' do
      within '#latest-article' do
        expect(page).to have_selector '.title h2', text: 'Latest article'
        expect(page).to have_selector '.info .read-more', text: 'Lees verder'
      end

      within '#next-to-last-articles' do
        expect(page).to have_selector '.title h2', text: 'Next to last article'
        expect(page).to have_selector '.title h2', text: 'Second article'
        expect(page).to have_selector '.title .read-more', text: 'Lees verder', count: 2
      end
    end

    within '#carousel .items ul' do
      expect(page).to have_selector 'li a .bg-image'
      expect(page).to have_selector 'li a .title', text: 'First article'

      expect(page).to have_no_selector 'li a .title', text: 'Second article'
      expect(page).to have_no_selector 'li a .title', text: 'Next to last article'
      expect(page).to have_no_selector 'li a .title', text: 'Latest article'

      expect(page).to have_selector 'li .empty', count: 5
    end

    within '#carousel .navigation ul' do
      expect(page).to have_selector 'li span', count: 1
    end
  end

  it 'shows multiple articles in the carousel on a single article page' do
    visit root_url
    visit_the_latest_article

    within '#carousel .items ul' do
      expect(page).to have_selector 'li a .title', text: 'First article'
      expect(page).to have_selector 'li a .title', text: 'Second article'
      expect(page).to have_selector 'li a .title', text: 'Next to last article'

      expect(page).to have_no_selector 'li a .title', text: 'Latest article'

      expect(page).to have_selector 'li .empty', count: 3
    end

    within '#carousel .navigation ul' do
      expect(page).to have_selector 'li span', count: 1
    end
  end

  context 'when there are even more articles' do
    let!(:article_5) { Fabricate :article, id: 5, title: 'Fifth article' }
    let!(:article_6) { Fabricate :article, id: 6, title: 'Sixth article' }
    let!(:article_7) { Fabricate :article, id: 7, title: 'Seventh article' }
    let!(:article_8) { Fabricate :article, id: 8, title: 'Eight article' }

    it 'shows more articles in the carousel than a single page can hold' do
      visit root_url
      visit article_url(latest_article)

      within '#carousel .items ul' do
        expect(page).to have_selector 'li a .title', text: 'First article'
        expect(page).to have_selector 'li a .title', text: 'Second article'
        expect(page).to have_selector 'li a .title', text: 'Next to last article'
        expect(page).to have_selector 'li a .title', text: 'Fifth article'
        expect(page).to have_selector 'li a .title', text: 'Sixth article'
        expect(page).to have_selector 'li a .title', text: 'Seventh article'
        expect(page).to have_selector 'li a .title', text: 'Eight article'

        expect(page).to have_no_selector 'li a .title', text: 'Latest article'

        expect(page).to have_selector 'li .empty', count: 5
      end

      within '#carousel .navigation ul' do
        expect(page).to have_selector 'li span', count: 2
      end
    end
  end

  context 'when there is an unpublished article' do
    let!(:unpublished) { Fabricate :article, id: 5, title: 'Unpublished article', created_at: Date.today, published: false }

    context 'allow a custom 404 error page to be shown' do
      before do
        method = Rails.application.method(:env_config)
        expect(Rails.application).to receive(:env_config).with(no_args) do
          method.call.merge(
            'action_dispatch.show_exceptions'          => true,
            'action_dispatch.show_detailed_exceptions' => false,
            'consider_all_requests_local'              => false
          )
        end
      end

      it 'shows a 404 page when I try to visit the unpublished article' do
        visit article_path(unpublished)

        within '.error #not_found #message' do
          expect(page).to have_selector 'h1', text: 'Uhoh...'
          expect(page).to have_content '404: File Not Found oftewel de pagina waar je naar op zoek bent bestaat niet. Het lijkt erop dat je verdwaald bent in een galaxy far, far away...'
          expect(page).to have_content '...dus ga terug naar de Melkweg. Err, New Media Freak'
        end
      end
    end

    it 'does not let you navigate between unpublished articles' do
      visit root_url

      within '#content .articles #latest-article' do
        expect(page).to have_no_selector '.title h2', text: 'Nieuw: Unpublished article'
        expect(page).to have_selector '.title h2', text: 'Nieuw: Latest article'
      end

      unpublished.update_attributes published: true

      visit root_url

      within '#content .articles #latest-article' do
        expect(page).to have_selector '.title h2', text: 'Nieuw: Unpublished article'
        expect(page).to have_no_selector '.title h2', text: 'Nieuw: Latest article'
      end
    end
  end

  context 'when there are tags applied to the latest article' do
    before { latest_article.tags = [ tag_1, tag_2, tag_3 ] }

    it 'shows an article with tags' do
      visit root_url
      visit_the_latest_article

      view_the_latest_article

      within '#single-article .article .tags' do
        expect(page).to have_content 'Tag 1, Tag 2 en Tag 3'
      end
    end
  end

  private

  def visit_the_latest_article
    within '#content .articles #latest-article' do
      find('.info .read-more a').click
    end
  end

  def view_the_latest_article
    within '#content #single-article' do
      within '.article' do
        expect(page).to have_selector '.title h2', text: 'Latest article'
        expect(page).to have_selector '.content', text: 'Content for the latest article.'
      end

      within '.navigation' do
        expect(page).to have_selector 'ul li.preceding a span.button', text: 'vorig artikel'
        expect(page).to have_selector 'ul li.preceding a span.title', text: 'Next to last article'

        expect(page).to have_no_selector 'ul li.succeeding a span.button'
        expect(page).to have_no_selector 'ul li.succeeding a span.title'
      end
    end
  end

  def view_the_next_to_last_article
    within '#content #single-article' do
      within '.article' do
        expect(page).to have_selector '.title h2', text: 'Next to last article'
        expect(page).to have_selector '.content', text: 'Content for the next-to-last article.'
      end

      within '.navigation' do
        expect(page).to have_selector 'ul li.preceding a span.button', text: 'vorig artikel'
        expect(page).to have_selector 'ul li.preceding a span.title', text: 'Second article'

        expect(page).to have_selector 'ul li.succeeding a span.button', text: 'volgend artikel'
        expect(page).to have_selector 'ul li.succeeding a span.title', text: 'Latest article'
      end
    end
  end

end
