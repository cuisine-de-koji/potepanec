class Potepan::HomesController < ApplicationController
  MONTH_FOR_NEW = 6
  def index
    # available_onが6ヶ月以内の商品を新着商品とする
    @new_products = Spree::Product.where("available_on > ?", Date.today.prev_month(MONTH_FOR_NEW)).order(available_on: :desc)
  end
end
