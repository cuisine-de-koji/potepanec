class Potepan::HomesController < ApplicationController
  def index
    # available_onが一ヶ月以内の商品を新着商品とする
    @new_products = Spree::Product.where("available_on > ?", Date.today.prev_month(1)).
      order(available_on: :desc)
  end
end
