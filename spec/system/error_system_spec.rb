require 'rails_helper'

RSpec.describe 'Error page', type: :system do

  context 'when the article exists' do
    let(:article) { Fabricate :article, id: 100, title: 'An article', created_at: 7.days.ago }

    it "doesn't show a custom 404 page" do
      visit article_path(article)

      within '#content #single-article .article' do
        expect(page).to have_selector '.title h2', text: 'An article'
      end

      expect(page).to have_no_selector '.error #not_found #message h1', text: 'Uhoh...'
      expect(page).to have_no_selector '.error #not_found #message p'

      expect(page).to have_no_content '404: File not found oftewel de pagina waar je naar op zoek bent bestaat niet. Het lijkt erop dat je verdwaald bent in een galaxy far, far away...'
    end
  end

  context 'when the article does not exist' do
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

    it 'shows a custom 404 page' do
      visit '/a-non-existing-article'

      within '.error #not_found #message' do
        expect(page).to have_selector 'h1', text: 'Uhoh...'
        expect(page).to have_content '404: File Not Found oftewel de pagina waar je naar op zoek bent bestaat niet. Het lijkt erop dat je verdwaald bent in een galaxy far, far away...'
        expect(page).to have_content '...dus ga terug naar de Melkweg. Err, New Media Freak'
      end
    end
  end

end
