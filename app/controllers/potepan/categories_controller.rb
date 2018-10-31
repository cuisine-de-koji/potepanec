class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = Spree::Product.joins(:taxons).includes_price_and_images.
      self_and_descendants_taxons(@taxon)
    @root_taxons = Spree::Taxon.roots
  end
end
