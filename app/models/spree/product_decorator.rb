Spree::Product.class_eval do
  scope :includes_price_and_images,   -> { includes(master: [:default_price, :images]) }
  scope :self_and_descendants_taxons, lambda { |taxon|
                                        where(spree_taxons: { id: taxon.self_and_descendants.ids })
                                      }
end
