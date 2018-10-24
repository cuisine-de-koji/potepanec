Spree::Taxon.class_eval do
  def show_products
    # taxonがrootノードかどうかで表示商品を場合分け
    if root?
      # 子供を持たない末端の葉っぱtaxonsのAR(ActiveRecord::Relation)商品群を取得後,
      # 重複がなくユニークで且つnilや空白を削除した配列に整形。
      # またN + 1問題を回避するために、事前に@taxon.leavesに関連する:productsとその:productsに関連する:master、そして
      # その:masterにdelegateされている:default_price(Spree::DefaultPrice)と:image(Spree::Image)をeagerload。
      leaves.includes(products: { master: [:default_price, :images] }).
        map(&:products).flatten.compact.uniq
    else
      products.includes(master: [:default_price, :images])
    end
  end
end
