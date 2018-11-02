class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_NUMS = 4
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @taxons_product_belong = @product.taxons
    @related_products = @taxons_product_belong.includes_price_and_images.
      map(&:products).flatten.compact.uniq.
      reject { |product| product.id == @product.id }.sample(RELATED_PRODUCTS_NUMS)
  end
end
