Spree::Product.class_eval do
  # scopeではクラスメソッドの'self'がいらない（含んでいる）
  scope :includes_price_and_images,   -> { includes(master: [:default_price, :images]) }
  scope :self_and_descendants_taxons, -> (taxon) { joins(:classifications).where(spree_products_taxons: { taxon_id: taxon.self_and_descendants.ids }) }
  scope :reject_self,                 -> (self_product) { where.not(id: self_product.id) }
  scope :random_and_limitted_items,   -> (nums) { where(id: pluck(:id).sample(nums)) }

  def related_products
    self.class.joins(:taxons).
      where(spree_taxons: { id: taxon_ids }).distinct.
      reject_self(self)
  end

  def self.filter_with_option_value(names)
    product_ids = Spree::Variant.joins(:option_values)
                                .where(spree_option_values:
                                      { name: names })
                                .pluck(:product_id).uniq
    where(id: product_ids)
  end
end
