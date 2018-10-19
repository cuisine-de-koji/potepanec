require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full_titleヘルパーメソッドのテスト' do
    context "page_titleが空の場合" do
      it "base_titleだけ表示されること" do
        expect(helper.full_title('')).to eq('BIGBAG Store')
      end
    end

    context "page_titleが空でない場合" do
      it "page_titleとbase_titleが表示されること" do
        expect(helper.full_title('PageTitle')).to eq('PageTitle | BIGBAG Store')
      end
    end
  end
end
