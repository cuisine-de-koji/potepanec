Spree::Taxon.class_eval do
  def show_products
    #taxonがrootノードかどうかで表示商品を場合分け
    if root?
      #子供を持たない末端の葉っぱtaxonsのAR(ActiveRecord::Relation)商品群を取得後,
      #重複がなくユニークでnilや空白を削除した配列に整形
      leaves.includes(:products).map(&:products).flatten.compact.uniq
    else
      products
    end
  end
end
