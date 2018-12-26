Spree::Taxon.class_eval do
  scope :includes_price_and_images, -> { includes(products: { master: [:default_price, :images] }) }
end
