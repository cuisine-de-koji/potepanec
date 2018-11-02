Spree::Product.class_eval do
  scope :includes_price_and_images,   -> { includes(master: [:default_price, :images]) }
  scope :self_and_descendants_taxons, -> (*taxons) {
                                        where(spree_taxons: { id: taxons.flatten.map { |taxon| taxon.self_and_descendants.ids }.flatten })
                                      }
  scope :reject_self,                 -> (self_product) { where.not(spree_products: { id: self_product.id }) }
end
