Spree::Product.class_eval do
  scope :includes_price_and_images,   -> { includes(master: [:default_price, :images]) }
  scope :self_and_descendants_taxons, -> (taxon) { joins(:taxons).where(spree_taxons: { id: taxon.self_and_descendants.ids }) }
  scope :related_products,            -> (product) { joins(:taxons).where(spree_taxons: { id: product.taxon_ids }).distinct }
  scope :reject_self,                 -> (self_product) { where.not(id: self_product.id) }
  # scopeではクラスメソッドでは必要な'self.'がいらない（含んでいる）
  scope :limiting_items,              -> (nums) { where(id: pluck(:id).sample(nums)) }
end
