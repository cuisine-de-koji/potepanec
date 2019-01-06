module Potepan
  class HomesController < Potepan::StoreController
    MONTH_FOR_NEW = 1
    FEATURE_CATEGORIES_NAME = %w(T-Shirts Bags Mugs).freeze
    def index
      # available_onが一ヶ月以内の商品を新着商品とする
      @new_products = Spree::Product.where("available_on > ?", Date.today.prev_month(MONTH_FOR_NEW)).order(available_on: :desc)
      @feature_categories = Spree::Taxon.where(name: FEATURE_CATEGORIES_NAME)
    end
  end
end
