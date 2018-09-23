class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @products = show_products(@taxon)
    @roots_taxon = Spree::Taxon.roots
  end

    private
      def show_products(taxon)
        if taxon.root?
          taxon.leaves.includes(:products).map(&:products).flatten.compact.uniq
        else
          taxon.products
        end
      end

end
