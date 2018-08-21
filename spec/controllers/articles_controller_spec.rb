require 'rails_helper'

RSpec.describe ArticlesController do

  let!(:published_1) { Fabricate :article, published: true }
  let!(:published_2) { Fabricate :article, published: true }
  let!(:unpublished) { Fabricate :article, published: false }

  describe 'GET index' do
    it 'retrieves the published articles' do
      get :index
      expect(assigns(:articles)).to match_array [ published_1, published_2 ]
    end
  end

  describe 'GET show' do
    let(:get_show) do
      get :show, params: { id: published_1.id }
    end

    it 'retrieves the specified published article' do
      get_show
      expect(assigns(:article)).to eq published_1
    end

    it 'retrieves the published articles without the specified article' do
      get_show
      expect(assigns(:articles)).to match_array [ published_2 ]
    end
  end

end
