class ProductFilter
  attr_reader :taxon, :view, :sorted, :option_value

  def initialize(params = {})
    @taxon = params[:taxon].presence
    @view = 'grid' || params[:view]
    @sorted = params[:sorted].presence
    @option_value = params['tshirt-color'.to_sym].presence || params['tshirt-size'.to_sym].presence
  end

  def filtered_products
    scopes = get_base_scopes(@taxon)
    scopes = scopes.filter_with_option_value(@option_value) if @option_value
    scopes
  end

  private

    def get_base_scopes(taxon = nil)
      return Spree::Product.in_taxon(taxon) if taxon

      Spree::Product.all
    end
end
