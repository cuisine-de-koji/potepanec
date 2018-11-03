require 'rails_helper'

RSpec.feature "product pages", type: :feature do
  given(:nike_taxon) { create :taxon }
  # taxonsは配列にしないといけないので[]で囲む
  given!(:product) { create :product, taxons: [nike_taxon] }
  given!(:same_taxon_product_1) { create :product, name: 'hoge', taxons: [nike_taxon] }
  given!(:same_taxon_product_2) { create :product, name: 'foo', taxons: [nike_taxon] }
  given!(:same_taxon_product_3) { create :product, name: 'bar', taxons: [nike_taxon] }
  given!(:same_taxon_product_4) { create :product, name: 'jojo', taxons: [nike_taxon] }
  given(:lonely_taxon) { create :taxon, name: "lonely_taxon" }
  given(:lonely_product) { create :product, name: "lonely_product", taxons: [lonely_taxon] }

  scenario "商品の内容が適切である" do
    visit potepan_product_path(product.id)
    expect(page).to have_content "一覧ページへ戻る"
    expect(page).to have_content product.name
    expect(page).to have_content product.price
    expect(page).to have_content product.description
  end

  scenario "click 一覧ページへ戻る" do
    visit potepan_product_path(product.id)
    click_on "一覧ページへ戻る"
    expect(page).to have_content nike_taxon.name
    expect(page).to have_current_path(potepan_category_path(nike_taxon.id))
  end

  scenario "関連商品の内容が適切である" do
    visit potepan_product_path(product.id)
    expect(page).to have_content product.name
    expect(page).to have_selector 'h5', text: same_taxon_product_1.name
    expect(page).to have_selector 'h5', text: same_taxon_product_2.name
    expect(page).to have_selector 'h5', text: same_taxon_product_3.name
    expect(page).to have_selector 'h5', text: same_taxon_product_4.name
  end

  scenario "関連商品が一つもないとき、関連商品に何も表示されない" do
    visit potepan_product_path(lonely_product.id)
    expect(page).to have_content "lonely_product"
    expect(page).not_to have_selector 'h5', text: same_taxon_product_1.name
    expect(page).not_to have_css '.productBoxs'
  end
end
