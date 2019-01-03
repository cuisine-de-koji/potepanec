class Potepan::CategoriesController < ApplicationController
  VALID_PARAMETER = %i(view sorted tshirt-size tshirt-color)

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = Spree::Product.self_and_descendants_taxons(@taxon).includes_price_and_images
    @root_taxons = Spree::Taxon.roots
    @category_view = params[:view] || "grid"
    @product_filter = ProductFilter.new(filter_params.merge(taxon: @taxon))
  end

  private

   def filter_params
     params.permit(*VALID_PARAMETER)
   end
end
