require 'rails_helper'

RSpec.feature "category pages", type: :feature do
  given(:root_taxonomy) { create :taxonomy }
  given(:child_taxon) { root_taxonomy.root.children.create(name: "Child") }
  given!(:root_products) { create_list :product, 3, taxons: [root_taxonomy.root] }
  given!(:child_products) { create_list :product, 4, taxons: [child_taxon] }

  feature "taxonに属するproductsの表示" do
    given(:color_taxonomy) { create :taxonomy, name: "Color" }
    given(:color_taxon) { color_taxonomy.root.children.create(name: "Red") }
    given!(:red_bag) { create :product, name: "Red Bag", taxons: [color_taxon] }

    context "taxonがroot(parent_idがnil)の場合" do
      background do
        visit potepan_category_path(root_taxonomy.root.id)
      end
      scenario "カテゴリーに表示されるタイトル、商品群が適切である" do
        expect(page).to have_selector 'div.page-title', text: root_taxonomy.root.name
        expect(page).to have_selector 'div.productBox', text: root_products.first.name
        expect(page).to have_selector 'div.productBox', text: root_products.second.name
        expect(page).to have_selector 'div.productBox', text: root_products.third.name
      end

      scenario "子孫taxonの商品(child_products)も表示されている" do
        expect(page).to have_selector 'div.page-title', text: root_taxonomy.root.name
        expect(page).to have_selector 'div.productBox', text: child_products.first.name
        expect(page).to have_selector 'div.productBox', text: child_products.second.name
        expect(page).to have_selector 'div.productBox', text: child_products.third.name
      end

      scenario "表示されるべきでないtaxon(color_taxon)の商品(red_bag)が表示されていない" do
        expect(page).to have_selector 'div.page-title', text: root_taxonomy.root.name
        expect(page).not_to have_selector 'div.productBox', text: "Red Bag"
      end

      scenario "click single_product" do
        visit potepan_product_path(root_products.first.id)
        expect(page).to have_selector 'div.singleProduct', text: root_products.first.name
        expect(page).to have_current_path(potepan_product_path(root_products.first.id))
      end
    end

    context "taxonがchild(parent_idがnilではない)の場合" do
      background do
        visit potepan_category_path(child_taxon.id)
      end
      scenario "カテゴリーに表示されるタイトル、商品群が適切である" do
        expect(page).to have_selector 'div.page-title', text: "Child"
        expect(page).to have_selector 'div.productBox', text: child_products.first.name
        expect(page).to have_selector 'div.productBox', text: child_products.second.name
        expect(page).to have_selector 'div.productBox', text: child_products.third.name
      end

      scenario "root_taxonの商品(root_products)が表示されていない" do
        expect(page).to have_selector 'div.page-title', text: "Child"
        expect(page).not_to have_selector 'div.productBox', text: root_products.first.name
      end

      scenario "表示されるべきでない関連のないtaxon(color_taxon)の商品(red_bag)が表示されていない" do
        expect(page).to have_selector 'div.page-title', text: "Child"
        expect(page).not_to have_selector 'div.productBox', text: "Red Bag"
      end

      scenario "click single_product" do
        visit potepan_product_path(child_products.first.id)
        expect(page).to have_selector 'div.singleProduct', text: child_products.first.name
        expect(page).to have_current_path(potepan_product_path(child_products.first.id))
      end
    end
  end

  feature "grid/listの切り替えが正しく動くか" do
    given!(:other_products) { create_list :product, 3, taxons: [child_taxon] }
    background do
      visit potepan_category_path(child_taxon.id)
    end

    context "ボタンを押したとき" do
      scenario "listボタンをクリックするとlist_viewに切り替わる" do
        click_on "List"
        expect(page).to have_current_path(potepan_category_path(child_taxon.id, view: :list))
        expect(page).to have_selector 'div.page-title', text: "Child"
        expect(page).to have_selector 'div.productListSingle', text: other_products.first.name
        expect(page).to have_selector 'div.productListSingle', text: other_products.second.name
        expect(page).to have_selector 'div.productListSingle', text: other_products.third.name
      end

      scenario "gridボタンをクリックするとgrid_viewが表示される" do
        click_on "Grid"
        expect(page).to have_current_path(potepan_category_path(child_taxon.id, view: :grid))
        expect(page).to have_selector 'div.page-title', text: "Child"
        expect(page).to have_selector 'div.productBox', text: other_products.first.name
        expect(page).to have_selector 'div.productBox', text: other_products.second.name
        expect(page).to have_selector 'div.productBox', text: other_products.third.name
      end
    end

    context "urlに直接params[:view]を打ち込んだとき" do
      scenario "get ':id?view=grid'" do
        visit potepan_category_path(child_taxon.id, view: :grid)
        expect(page).to have_current_path(potepan_category_path(child_taxon.id, view: :grid))
        expect(page).to have_selector 'div.page-title', text: "Child"
        expect(page).to have_selector 'div.productBox', text: other_products.first.name
        expect(page).to have_selector 'div.productBox', text: other_products.second.name
        expect(page).to have_selector 'div.productBox', text: other_products.third.name
      end
      scenario "get ':id?view=list'" do
        visit potepan_category_path(child_taxon.id, view: :list)
        expect(page).to have_current_path(potepan_category_path(child_taxon.id, view: :list))
        expect(page).to have_selector 'div.page-title', text: "Child"
        expect(page).to have_selector 'div.productListSingle', text: other_products.first.name
        expect(page).to have_selector 'div.productListSingle', text: other_products.second.name
        expect(page).to have_selector 'div.productListSingle', text: other_products.third.name
      end
    end
  end
end
