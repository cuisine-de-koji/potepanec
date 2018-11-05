require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    let(:categories) { create(:taxonomy, name: 'Categories') }
    let(:dinasor) { categories.root.children.create(name: 'Dinasor', taxonomy: categories) }
    let(:dinasors_list) { create_list(:product, 8, taxons: [dinasor]) }
    let(:lonely_taxon) { create :taxon, name: "lonely_taxon" }
    let(:lonely_product) { create :product, name: "lonely_product", taxons: [lonely_taxon] }

    before do
      get :show, params: { id: dinasors_list.first.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      expect(response).to render_template :show
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq dinasors_list.first
    end

    it "assigns @taxons_product_belong" do
      expect(assigns(:taxons_product_belong)).to eq dinasors_list.first.taxons
    end

    it "assigns @related_product # 関連商品に現在の商品自身が含まれない" do
      expect(assigns(:related_products)).not_to match dinasors_list.first
    end

    it "assigns @related_product # 関連商品の数が8個以下である" do
      expect(assigns(:related_products).size).to be <= 8
    end

    it "assigns @related_product # 関連商品が一つもない商品の場合@related_productに何も入らない(空の配列になる)" do
      get :show, params: { id: lonely_product.id }
      expect(assigns(:related_products)).to eq []
    end
  end
end
