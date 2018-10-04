require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let(:taxon) { create :taxon }

    before do
      get :show, params: { id: taxon.id }
    end

    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end

    it '@taxonに適切なプロダクトを割り当てること' do
      expect(assigns(:taxon)).to eq taxon
    end

    it ':showテンプレートを表示すること' do
      expect(response).to render_template :show
    end
  end
end
