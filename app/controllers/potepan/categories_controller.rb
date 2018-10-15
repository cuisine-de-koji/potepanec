class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = @taxon.show_products
    @roots_taxon = Spree::Taxon.roots
  end
end
