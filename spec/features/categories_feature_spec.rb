require 'rails_helper'

RSpec.feature "category pages", type: :feature do
  let(:root) { create :taxon }
  # parentはawsome_nestedを使用している
  let(:child) { create :taxon, parent: root }
  let(:root_products) { create_list :product, 3, taxons: [root] }
  let(:child_products) { create_list :product, 4, taxons: [child] }

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
