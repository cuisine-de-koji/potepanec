class ProductFilter
  attr_reader :taxon, :view, :sort, :option_value, :keyword

  def initialize(params = {})
    @taxon = params[:taxon].presence
    @view = params[:view] || 'grid'
    @sort = params[:sort].presence
    @option_value = params['tshirt-color'.to_sym].presence || params['tshirt-size'.to_sym].presence
    @keyword = params['keyword'].presence
  end

  def filtered_products
    scopes = get_base_scopes(@taxon)
    scopes = scopes.filter_with_option_value(@option_value) if @option_value
    scopes = scopes.search_with(keyword) if keyword
    if @sort
      case @sort
      when 'price_up' then
        scopes = scopes.price_high
      when 'price_down' then
        scopes = scopes.price_low
      when 'oldest' then
        scopes = scopes.oldest
      else
        scopes = scopes.newest
      end
    else
      scopes
    end
    scopes
  end

   def sort_select_collection
     { '新着順': 'newest',
       '値段の高い順': 'price_up',
       '値段の低い順': 'price_down',
       '古い順': 'oldest' }
   end


  private

    def get_base_scopes(taxon = nil)
      return Spree::Product.in_taxon(taxon) if taxon

      Spree::Product.all
    end
end
