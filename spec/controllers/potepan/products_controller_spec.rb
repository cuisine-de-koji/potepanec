require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  let(:categories) { create(:taxonomy, name: 'Categories') }
  let(:dinasor) { categories.root.children.create(name: 'Dinasor', taxonomy: categories) }
  let(:dinasors_list) { create_list(:product, 8, taxons: [dinasor]) }

  before do
    get :show, params: { id: dinasors_list.first.id }
  end

  describe 'GET #index' do
    it 'レスポンス成功' do
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'index template をレンダリング' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders show template" do
      expect(response).to render_template :show
    end
  end

  describe '@related_products' do
    let(:dog) { categories.root.children.create(name: 'Dog', taxonomy: categories) }
    let(:cute_dog) { create :product, name: "Cute_dog", taxons: [dog] }

    context "関連商品がある場合" do
      it "assigns @product" do
        expect(assigns(:product)).to eq dinasors_list.first
      end

      it "assigns @related_product # 関連商品に現在の商品自身が含まれない" do
        expect(assigns(:related_products)).not_to include dinasors_list.first
      end

      it "assigns @related_product # 関連商品の数が8個以下である" do
        expect(assigns(:related_products).size).to be <= 8
      end
    end

    context "関連商品がない場合" do
      it "assigns @related_product # @related_productに何も入らない(空の配列になる)" do
        get :show, params: { id: cute_dog.id }
        expect(assigns(:related_products)).to be_empty
      end
    end
  end
end
