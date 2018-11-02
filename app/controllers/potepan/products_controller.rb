class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_NUMS = 4
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @taxons_product_belong = @product.taxons
    @related_products = Spree::Product.joins(:taxons).
      includes_price_and_images.self_and_descendants_taxons(@taxons_product_belong).
      reject_self(@product).uniq.sample(RELATED_PRODUCTS_NUMS)
  end
end
