require 'rails_helper'

RSpec.describe TagsController do

  let!(:tag)         { Fabricate :tag }
  let!(:published_1) { Fabricate :article, published: true, tags: [ tag ] }
  let!(:published_2) { Fabricate :article, published: true }

  describe 'GET show' do
    let(:get_show) do
      get :show, params: { id: tag.id }
    end

    it 'retrieves the published articles' do
      get_show
      expect(assigns(:articles)).to match_array [ published_1, published_2 ]
    end

    it 'retrieves the tagged published articles' do
      get_show
      expect(assigns(:tagged_articles)).to match_array [ published_1 ]
    end
  end

end
