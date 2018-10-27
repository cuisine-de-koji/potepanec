class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.show_products
    @root_taxons = Spree::Taxon.roots
    @category_view = params[:view] || "grid"
  end
end
