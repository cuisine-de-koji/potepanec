require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  let!(:categories) { create(:taxonomy, name: 'Categories') }
  let!(:dinasor) { categories.root.children.create(name: 'Dinasor') }
  let!(:dinasors_list) { create_list(:product, 10, taxons: [dinasor]) }
  let!(:dinasor_1) { dinasors_list.first }
  let!(:dog) { categories.root.children.create(name: 'Dog') }
  let!(:dog_1) { create(:product, name: 'DOG', taxons: [dog]) }

  describe "#related_products" do
    context '関連商品がある場合' do
      let(:dinasor_related_products) { dinasor_1.related_products }

      it '関連商品が適切に取得できている' do
        expect(dinasor_related_products).to match_array dinasors_list - [dinasor_1]
      end

      it '関連商品は空ではない' do
        expect(dinasor_related_products).not_to be_empty
      end

      it 'プロダクトAの関連商品に自身のプロダクト（プロダクトA）を含んでいない' do
        expect(dinasor_related_products).not_to include dinasor_1
      end

      it '他のtaxonの商品を含んでいない' do
        expect(dinasor_related_products).not_to include dog_1
      end
    end

    context '関連商品がない場合' do
      let(:dog_related_products) { dog_1.related_products }

      it '関連商品は空である' do
        expect(dog_related_products).to eq []
      end
    end
  end

  describe "scope" do
    describe "#random_and_limitted_items" do
      it '商品数がlimitの数となる' do
        limit = 8
        expect(Spree::Product.random_and_limitted_items(limit).count).to eq 8
      end
    end

    describe "#reject_self" do
      it '取得した関連商品から詳細商品自身は省かれている' do
        expect(Spree::Product.reject_self(dinasor_1)).not_to include dinasor_1
      end
    end
  end
end
