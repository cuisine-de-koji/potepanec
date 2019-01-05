module Potepan
  class OrdersController < Potepan::StoreController
    def edit
      @order = current_order
    end

    def add_cart
      @order = current_order(create_order_if_necessary: true)
      variant = Spree::Variant.find(params[:variant_id])
      quantity = params[:quantity].to_i

      @order.content.add(variant, quantify)

      binding.pry
      redirect_to potepan_cart_url
    end
  end
end
