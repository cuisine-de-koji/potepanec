class Potepan::ProductsController < ApplicationController
  RELATED_PRODUCTS_NUMS = 8
  def show
    @product = Spree::Product.find(params[:id])
    @images = @product.images
    @related_products = @product.
      related_products.
      includes_price_and_images.
      random_and_limitted_items(RELATED_PRODUCTS_NUMS)
  end

  def index
    @view = params[:view]
    @roots = Spree::Taxon.roots
    if request.query_parameters.any?
      @products = load_filter_products_by(option_values_names)
    else
      @products = Spree::Product.all
    end
  end

  private

    def load_filter_products_by(option_values_names)
      product_ids = Spree::Variant.joins(:option_values)
                                  .where(spree_option_values:
                                        { name: option_values_names })
                                  .pluck(:product_id).uniq
      Spree::Product.where(id: product_ids)
    end

    def option_values_names
      params.slice(*valid_option_values).values
    end

    def valid_option_values
      %w(tshirt-color tshirt-size)
    end
end
