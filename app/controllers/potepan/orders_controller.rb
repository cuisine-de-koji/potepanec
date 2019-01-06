module Potepan
  class OrdersController < Potepan::StoreController
    def edit
      @order = current_order || Spree::Order.incomplete.find_or_initialize_by(guest_token: cookies.signed[:guest_token])
    end

    def update
    end

    def add_cart
      @order = current_order(create_order_if_necessary: true)
      variant = Spree::Variant.find(params[:variant_id])
      quantity = params[:quantity].to_i

      @order.contents.add(variant, quantity)

      redirect_to potepan_cart_url
    end
  end
end
