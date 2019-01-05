module Potepan
  class OrdersController < Potepan::StoreController
    def edit
    end

    def add_cart
      variant = Spree::Variant.find(params[:variant_id])
      quantity = params[:quantity].to_i
      @order = current_order


      binding.pry
      redirect_to potepan_cart_url
    end
  end
end
