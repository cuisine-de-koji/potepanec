require 'rails_helper'

RSpec.feature "product pages", type: :feature do
  # cute_taxonとそれに属する商品群
  # taxonsは配列にしないといけないので[]で囲む
  given(:taxonomy) { create :taxonomy, name: "Love" }
  given(:cute_taxon) { taxonomy.root.children.create(name: "Cute") }
  given(:pink_bag) { create :product, name: "Pink Bag", taxons: [cute_taxon] }

  background do
    visit potepan_product_path(pink_bag.id)
  end

  feature "商品詳細の表示" do
    scenario "商品(:pink_bag)の内容が適切に表示されている" do
      expect(page).to have_selector 'div.singleProduct', text: "一覧ページへ戻る"
      expect(page).to have_selector 'div.singleProduct', text: pink_bag.name
      expect(page).to have_selector 'div.singleProduct', text: pink_bag.price
      expect(page).to have_selector 'div.singleProduct', text: pink_bag.description
    end

    scenario "click '一覧ページへ戻る'が正常に動く" do
      click_on "一覧ページへ戻る"
      expect(page).to have_selector 'div.page-title', text: cute_taxon.name
      expect(page).to have_current_path(potepan_category_path(cute_taxon.id))
    end
  end

  feature "関連商品の表示" do
    given!(:other_cute_bags) { create_list :product, 10, name: "KAWAII_KABAN", taxons: [cute_taxon] }
    # 商品が１つしかないtaxonとその商品
    given(:cool_taxon) { taxonomy.root.children.create(name: "Cool") }
    given(:lonely_bag) { create :product, name: "Lonely Bag", taxons: [cool_taxon] }

    context "関連商品がある場合" do
      scenario "cute_taxonに属する関連商品が適切に表示されている" do
        visit potepan_product_path(pink_bag.id)
        expect(page).to have_selector 'div.singleProduct', text: pink_bag.name
        expect(page).to have_selector 'div.productBox', text: "KAWAII_KABAN"
      end

      scenario "関連商品から、現在の商品詳細に表示されている商品自身（Pink Bag'）が省かれている" do
        visit potepan_product_path(pink_bag.id)
        expect(page).to have_selector 'div.singleProduct', text: pink_bag.name
        expect(page).not_to have_selector 'div.productBox', text: pink_bag.name
        expect(page).to have_selector 'div.productBox', text: other_cute_bags.first.name
      end

      scenario "cute_taxonに属する商品の数が(テストDBでは11個あるが)8個のみ表示されている" do
        visit potepan_product_path(pink_bag.id)
        expect(page).to have_selector 'div.singleProduct', text: pink_bag.name
        expect(page).not_to have_selector 'div.productBox', text: pink_bag.name
        expect(page).to have_selector 'div.productBox', text: other_cute_bags.first.name, count: 8
        expect(page).to have_css '.productBox', count: 8
      end
    end

    context "関連商品がない場合" do
      scenario "関連商品に何も表示されない" do
        visit potepan_product_path(lonely_bag.id)
        expect(page).to have_selector 'div.singleProduct', text: lonely_bag.name
        expect(page).not_to have_content pink_bag.name
        expect(page).not_to have_css '.productBox'
      end
    end
  end
end
