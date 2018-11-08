class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_NUMS = 8
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @related_products = @product.
      related_products.
      includes_price_and_images.
      limiting_items(RELATED_PRODUCTS_NUMS)
  end
end
