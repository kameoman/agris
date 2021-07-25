require 'rails_helper'

RSpec.describe '投稿データの確認', type: :request do
  describe '投稿データの作成後の動き' do
    let(:customer) { create(:customer) }
    let!(:item) { create(:item, customer: customer) }

    before do
      sign_in customer
    end

    it 'Itemが削除されること' do
      expect do
        delete item_path(item.id)
      end.to change(Item, :count).by(-1) # destroyしたことによって-1になる
    end

    context '編集関係の確認' do
      it 'Itemが投稿されたあと編集画面へ遷移できること' do
        expect do
          visit edit item_path(item.id)
          expect(current_path).to eq '/items/' + item.id.to_s + '/edit'
        end
      end
      it 'Itemが投稿されたあと編集画面へ遷移できること' do
        expect do
          edit item_path(item.id)
          expect(page).to have_content ''
        end
      end

      it '名前編集フォームが表示される' do
        expect do
          visit edit item_path(item.id)
          expect(page).to have_field 'item[name]', with: item.name
        end
      end
      it '規格編集フォームが表示される' do
        expect do
          visit edit item_path(item.id)
          expect(page).to have_field 'item[standard]', with: item.standard
        end
      end
      it '規格編集フォームが表示される' do
        expect do
          visit edit item_path(item.id)
          expect(page).to have_content '投稿データの編集'
        end
      end
    end
  end
end
