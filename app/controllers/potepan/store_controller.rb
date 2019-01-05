module Potepan
  class StoreController < ApplicationController
    # code -> solidus_core/lib/spree/controller_helpers/auth.rb
    #
    # methods
    # -------------
    # set_token
    # -> Storecontroller を継承したcontroller を通ると guest_token が cookie[:guest_token]
    # 保存される
    include Spree::Core::ControllerHelpers::Auth

    # code -> solidus_core/lib/spree/controller_helpers/order.rb
    #
    # methods
    # --------------
    # current_order
    # -> 現在の ユーザー または、guest_token に紐付いている order を返す
    # すでに order がある場合は、imcomplete のものを token or user_id で探す
    # ないものは、新たに order を create する
    include Spree::Core::ControllerHelpers::Order

    # code -> solidus_core/lib/spree/controller_helpers/price.rb
    #
    include Spree::Core::ControllerHelpers::Pricing

    # code -> solidus_core/lib/spree/controller_helpers/store.rb
    #
    include Spree::Core::ControllerHelpers::Store
  end
end
