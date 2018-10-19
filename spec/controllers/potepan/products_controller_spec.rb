require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'Get #show' do
    let(:konomi) { create :product }

    before do
      get :show, params: { id: konomi.id }
    end

    it 'リクエストがsuccessとなること' do
      expect(response).to be_success
    end

    it '@productに適切なプロダクトを割り当てること' do
      expect(assigns(:product)).to eq konomi
    end

    it ':showテンプレートを表示すること' do
      expect(response).to render_template :show
    end
  end
end
