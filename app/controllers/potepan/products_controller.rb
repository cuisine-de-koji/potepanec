class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_NUMS = 8
  VALID_PARAMETER = %i(view sorted tshirt-size tshirt-color).freeze

  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @related_products = @product.
      related_products.
      includes_price_and_images.
      random_and_limitted_items(RELATED_PRODUCTS_NUMS)
  end

  def index
    @view = params[:view]
    @roots = Spree::Taxon.roots

    @product_filter = ProductFilter.new(filter_params)
    @products = @product_filter.filtered_products
  end

  private

    def filter_params
      params.permit(*VALID_PARAMETER)
    end
end
