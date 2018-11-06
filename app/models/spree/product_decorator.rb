Spree::Product.class_eval do
  scope :includes_price_and_images,   -> { includes(master: [:default_price, :images]) }
  scope :related_products,            -> (product) { joins(:taxons).where(spree_taxons: { id: product.taxon_ids }).distinct }
  scope :reject_self,                 -> (self_product) { where.not(id: self_product.id) }
  scope :limiting_items,              -> (num) { where(id: pluck(:id).sample(num)) }
end
