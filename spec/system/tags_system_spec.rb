require 'rails_helper'

RSpec.describe 'Tags', type: :system do

  let!(:first_article)        { Fabricate :article, id: 1, title: 'First article', created_at: 4.days.ago, content: 'Content for the first article.' }
  let!(:second_article)       { Fabricate :article, id: 2, title: 'Second article', created_at: 3.days.ago, content: 'Content for the second article.' }
  let!(:next_to_last_article) { Fabricate :article, id: 3, title: 'Next to last article', created_at: 2.days.ago, content: 'Content for the next-to-last article.' }
  let!(:latest_article)       { Fabricate :article, id: 4, title: 'Latest article', created_at: 1.day.ago, content: 'Content for the latest article.' }

  let!(:tag_1) { Fabricate :tag, name: 'Tag 1' }
  let!(:tag_2) { Fabricate :tag, name: 'Tag 2' }
  let!(:tag_3) { Fabricate :tag, name: 'Tag 3' }

  before { visit root_url }

  context 'viewing a list of articles through a tag' do
    before do
      latest_article.tags       = [ tag_1, tag_2, tag_3 ]
      next_to_last_article.tags = [ tag_1 ]
    end

    it 'shows the articles that are tagged with the specified tag' do
      within '#content .articles #latest-article' do
        find('.info .read-more a').click
      end

      within '#single-article .article .tags' do
        click_link 'Tag 1'
      end

      within '.tags' do
        expect(page).to have_content "Artikelen getagged met 'Tag 1':"

        within '#tagged-articles' do
          within '.article:first' do
            expect(page).to have_selector '.title h2', text: 'Latest article'
            expect(page).to have_selector '.title .read-more', text: 'Lees verder'
          end

          within all('.article').last do
            expect(page).to have_selector '.title h2', text: 'Next to last article'
            expect(page).to have_selector '.title .read-more', text: 'Lees verder'
          end
        end
      end
    end

    it 'only show the latest article when a tag only applied to that article is selected' do
      visit article_path(latest_article)

      within '#single-article .article .tags' do
        click_link 'Tag 2'
      end

      within '.tags' do
        expect(page).to have_content "Artikelen getagged met 'Tag 2':"

        within '#tagged-articles' do
          within '.article:first' do
            expect(page).to have_selector '.title h2', text: 'Latest article'
            expect(page).to have_selector '.title .read-more', text: 'Lees verder'
          end

          expect(page).to have_no_selector '.title h2', text: 'Next to last article'
        end
      end
    end
  end
end
