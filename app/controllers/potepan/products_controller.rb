module Potepan
  class ProductsController < Potepan::StoreController
    RELATED_PRODUCTS_NUMS = 8
    VALID_PARAMETER = %i(view sort tshirt-size tshirt-color keyword).freeze

    before_action :set_roots, only: [:index, :search]

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
      @root_taxons = Spree::Taxon.roots
      @product_filter = ProductFilter.new(filter_params)
      @products = @product_filter.filtered_products
    end

    def search
      @product_filter = ProductFilter.new(filter_params)
      @products = @product_filter.filtered_products

      redirect_to potepan_products_url unless params[:keyword].present?
    end

    private

    def filter_params
      params.permit(*VALID_PARAMETER)
    end

    def set_roots
      @root_taxons = Spree::Taxon.roots
    end
  end
end
