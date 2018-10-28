require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe 'GET #show' do
    let(:categories) { create(:taxonomy, name: 'Categories') }
    let(:dinasor) do
      categories.root.children.create(name: 'Dinasor', taxonomy: categories)
    end
    let(:dinasors_list) do
      %w(big middle small).map do |name|
        create(:product, name: "#{name}-dinasor") do |product|
          product.taxons << dinasor
        end
      end
    end

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

    it "assigns @related_product" do
      expect(assigns(:related_products)).to match_array dinasors_list
    end
  end
end
