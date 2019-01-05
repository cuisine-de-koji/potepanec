module Potepan
  class OrdersController < Potepan::StoreController
    def edit
    end

    def add_cart
      binding.pry
      redirect_to potepan_cart_url
    end
  end
end
