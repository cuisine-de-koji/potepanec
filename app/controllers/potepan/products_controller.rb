class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_NUMS = 8
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @related_products = Spree::Product.
      related_products(@product).
      includes_price_and_images.
      reject_self(@product).
      limiting_items(RELATED_PRODUCTS_NUMS)
  end
end
