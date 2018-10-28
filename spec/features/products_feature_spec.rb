require 'rails_helper'

RSpec.feature "product pages", type: :feature do
  let(:root) { create :taxon }
  # taxonsは配列にしないといけないので[]で囲む
  let(:product) { create :product, taxons: [root] }

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
    expect(page).to have_content root.name
    expect(page).to have_current_path(potepan_category_path(root.id))
  end
end
