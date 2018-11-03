require 'rails_helper'

RSpec.feature "category pages", type: :feature do
  given(:root) { create :taxon }
  # parentはawesome_nested_listを使用している
  given(:child) { create :taxon, parent: root }
  given(:root_products) { create_list :product, 3, taxons: [root] }
  given(:child_products) { create_list :product, 4, taxons: [child] }
  given!(:other_products) { create_list :product, 3, taxons: [child] }

  feature "taxonに属するproductsの表示が適切か" do
    context "taxonがroot(parent_idがnil)の場合" do
      scenario "カテゴリーに表示されるタイトル、商品群が適切である" do
        visit potepan_category_path(root_products.first.taxons.ids.first)
        expect(page).to have_selector 'h2', text: root.name
        expect(page).to have_selector 'h5', text: root_products.first.name
        expect(page).to have_selector 'h5', text: root_products.second.name
        expect(page).to have_selector 'h5', text: root_products.third.name
      end

      scenario "他のtaxonの商品が表示されていない" do
        visit potepan_category_path(root_products.first.taxons.ids.first)
        expect(page).to have_selector 'h2', text: root.name
        expect(page).not_to have_selector 'h5', text: child_products.first.name
      end

      scenario "click single_product" do
        visit potepan_product_path(root_products.first.id)
        expect(page).to have_content root_products.first.name
        expect(page).to have_current_path(potepan_product_path(root_products.first.id))
      end
    end

    context "taxonがchild(parent_idがnilではない)の場合" do
      scenario "カテゴリーに表示されるタイトル、商品群が適切である" do
        visit potepan_category_path(child_products.first.taxons.ids.first)
        expect(page).to have_selector 'h2', text: child.name
        expect(page).to have_selector 'h5', text: child_products.first.name
        expect(page).to have_selector 'h5', text: child_products.second.name
        expect(page).to have_selector 'h5', text: child_products.third.name
      end

      scenario "他のtaxonの商品が表示されていない" do
        visit potepan_category_path(child_products.first.taxons.ids.first)
        expect(page).to have_selector 'h2', text: child.name
        expect(page).not_to have_selector 'h5', text: root_products.first.name
      end

      scenario "click single_product" do
        visit potepan_product_path(child_products.first.id)
        expect(page).to have_content child_products.first.name
        expect(page).to have_current_path(potepan_product_path(child_products.first.id))
      end
    end
  end

  feature "grid/listの切り替えが正しく動くか" do
    context "ボタンを押したとき" do
      scenario "listボタンをクリックするとlist_viewに切り替わる" do
        visit potepan_category_path(child.id)
        click_on "List"
        expect(page).to have_current_path(potepan_category_path(child.id, view: :list))
        expect(page).to have_selector 'h2', text: child.name
        expect(page).to have_selector 'h4', text: other_products.first.name
        expect(page).to have_selector 'h4', text: other_products.second.name
        expect(page).to have_selector 'h4', text: other_products.third.name
      end

      scenario "gridボタンをクリックするとgrid_viewが表示される" do
        visit potepan_category_path(child.id)
        click_on "Grid"
        expect(page).to have_current_path(potepan_category_path(child.id, view: :grid))
        expect(page).to have_selector 'h2', text: child.name
        expect(page).to have_selector 'h5', text: other_products.first.name
        expect(page).to have_selector 'h5', text: other_products.second.name
        expect(page).to have_selector 'h5', text: other_products.third.name
      end
    end

    context "urlに直接params[:view]を打ち込んだとき" do
      scenario "get ':id?view=grid'" do
        visit potepan_category_path(child.id, view: :grid)
        expect(page).to have_current_path(potepan_category_path(child.id, view: :grid))
        expect(page).to have_selector 'h2', text: child.name
        expect(page).to have_selector 'h5', text: other_products.first.name
        expect(page).to have_selector 'h5', text: other_products.second.name
        expect(page).to have_selector 'h5', text: other_products.third.name
      end
      scenario "get ':id?view=list'" do
        visit potepan_category_path(child.id, view: :list)
        expect(page).to have_current_path(potepan_category_path(child.id, view: :list))
        expect(page).to have_selector 'h2', text: child.name
        expect(page).to have_selector 'h4', text: other_products.first.name
        expect(page).to have_selector 'h4', text: other_products.second.name
        expect(page).to have_selector 'h4', text: other_products.third.name
      end
    end
  end
end
