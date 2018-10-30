require 'rails_helper'

RSpec.feature "product pages", type: :feature do
  let(:hoge_taxon) { create :taxon }
  # taxonsは配列にしないといけないので[]で囲む
  let!(:product) { create :product, taxons: [hoge_taxon] }
  let!(:same_taxon_product_1) { create :product, name: 'hoge', taxons: [hoge_taxon] }
  let!(:same_taxon_product_2) { create :product, name: 'foo', taxons: [hoge_taxon] }
  let!(:same_taxon_product_3) { create :product, name: 'bar', taxons: [hoge_taxon] }
  let!(:same_taxon_product_4) { create :product, name: 'jojo', taxons: [hoge_taxon] }

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
    expect(page).to have_content hoge_taxon.name
    expect(page).to have_current_path(potepan_category_path(hoge_taxon.id))
  end

  scenario "関連商品の内容が適切である" do
    visit potepan_product_path(product.id)
    expect(page).to have_content product.name
    expect(page).to have_selector 'h5', text: same_taxon_product_1.name
    expect(page).to have_selector 'h5', text: same_taxon_product_2.name
    expect(page).to have_selector 'h5', text: same_taxon_product_3.name
    expect(page).to have_selector 'h5', text: same_taxon_product_4.name
  end
end
