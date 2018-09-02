require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'Get #show' do
    before do
      @product = create(:product)
      get :show, params: {id: @product.id}
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it '@productに適切なプロダクトを割り当てること' do
      expect(assigns(:product)).to eq @product
    end
    it ':showテンプレートを表示すること' do
      expect(response).to render_template :show
    end
  end
end
