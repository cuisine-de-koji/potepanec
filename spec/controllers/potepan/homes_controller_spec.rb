require 'rails_helper'

RSpec.describe Potepan::HomesController, type: :controller do
  describe "GET #index" do
    let(:new_products) { create_list(:product, 3, available_on: Date.today) }
    let(:not_new_products) { create_list(:product, 3, available_on: Date.today.prev_month(2)) }

    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it ":index テンプレートが正しく表示される" do
      expect(response).to render_template :index
    end

    it "@new_productsに正しくproductが割り当てられていること" do
      expect(assigns(:new_products)).to match new_products
    end

    it "@new_productsに新着商品ではないproductが割り当てられていないこと" do
      expect(assigns(:not_new_products)).not_to match new_products
    end
  end
end
