class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = Spree::Product.joins(:taxons).includes(master: [:default_price, :images]).
      where(spree_taxons: { id: @taxon.self_and_descendants.ids })
    @root_taxons = Spree::Taxon.roots
    @category_view = params[:view] || "grid"
  end
end
