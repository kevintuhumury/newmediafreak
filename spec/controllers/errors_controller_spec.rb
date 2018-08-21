require 'rails_helper'

RSpec.describe ErrorsController do

  describe 'GET /404' do
    before { allow(controller).to receive(:code).and_return 404 }

    it 'renders the 404 error page' do
      expect(controller).to receive(:render).with(action: 'error', layout: 'error', locals: { error: 404 }, status: 404).and_call_original
      get :render_error
    end
  end

end
