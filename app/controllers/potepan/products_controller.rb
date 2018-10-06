class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
  end
end
