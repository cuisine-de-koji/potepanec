class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @related_products = Spree::Taxon.find(@product.taxon_ids.first).products.sample(4)
  end
end
