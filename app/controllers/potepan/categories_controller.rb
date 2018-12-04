class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = Spree::Product.self_and_descendants_taxons(@taxon).includes_price_and_images
    @root_taxons = Spree::Taxon.roots
    @category_view = params[:view] || "grid"
  end
end
