Spree::Product.class_eval do
  # scopeではクラスメソッドの'self'がいらない（含んでいる）
  scope :includes_price_and_images,   -> { includes(master: [:default_price, :images]) }
  scope :reject_self,                 -> (self_product) { where.not(id: self_product.id) }
  scope :random_and_limitted_items,   -> (nums) { where(id: pluck(:id).sample(nums)) }
  scope :newest, -> { available.distinct.reorder(available_on: :desc) }
  scope :oldest, -> { available.distinct.reorder(available_on: :asc) }
  scope :price_low, -> { select('spree_products.*, spree_prices.amount').joins(master: :default_price).reorder(Spree::Price.arel_table[:amount].asc) }
  scope :price_high, -> { select('spree_products.*, spree_prices.amount').joins(master: :default_price).reorder(Spree::Price.arel_table[:amount].desc) }
  scope :search_with, -> (keyword) { where('name LIKE :keyword OR description LIKE :keyword', keyword: "%#{Spree::Product.escape_meta(keyword)}%") }



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

  private

  def self.escape_meta(string)
    string.gsub(/[%_]/) { |m| "\\#{m}" }
  end
end
