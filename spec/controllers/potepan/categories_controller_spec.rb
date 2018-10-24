require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe 'Get #show' do
    let(:taxonomy) { create(:taxonomy) }
    let(:apple) do
      taxonomy.root.children.create(name: 'Apple', taxonomy: taxonomy)
    end
    # 上記の様な形で:apple(spree_taxon)を作るのはtaxon_decorator#show_productsで'leaves'メソッドを使用しているから。
    # :appleがrootノードになってしまうと、if分岐で'leaves'が働き、自身(:apple)を除いたproductsを返すので戻り値がnilになる。
    # solidusのデフォルトfactoryが:taxonにおいて'parent_id = nil'を返すのが原因。
    let(:products_list) do
      %w(air pro mini).map do |name|
        create(:product, name: "#{name}") do |product|
          product.taxons << apple
        end
      end
    end

    before do
      get :show, params: { id: apple.id }
    end

    it 'リクエストがsuccessとなること' do
      expect(response).to be_success
    end

    it '@taxonに適切なカテゴリーを割り当てること' do
      expect(assigns(:taxon)).to eq apple
    end

    it '@taxonに属する製品が正しく割り当てられている' do
      expect(assigns(:products)).to eq products_list
    end
  end
end
