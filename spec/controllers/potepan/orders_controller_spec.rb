require 'rails_helper'

RSpec.describe Potepan::OrdersController, type: :controller do

  describe "GET #add_cart" do
    it "returns http success" do
      get :add_cart
      expect(response).to have_http_status(:success)
    end
  end

end
