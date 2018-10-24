class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.show_products
    @root_taxons = Spree::Taxon.roots
  end
end
