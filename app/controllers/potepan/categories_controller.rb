module Potepan
  class CategoriesController < Potepan::StoreController
    VALID_PARAMETER = %i(view sort tshirt-size tshirt-color keyword).freeze

    def show
      @taxon = Spree::Taxon.find(params[:id])
      @product_filter = ProductFilter.new(filter_params.merge(taxon: @taxon))
      @products = @product_filter.filtered_products
      @root_taxons = Spree::Taxon.roots
      @category_view = params[:view] || "grid"
    end

    private

    def filter_params
      params.permit(*VALID_PARAMETER)
    end
  end
end
