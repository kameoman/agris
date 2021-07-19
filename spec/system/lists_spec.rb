require 'rails_helper'

describe '投稿のテスト' do

  describe 'トップ画面(top_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面に「アプリケーションの名前Agris」が表示されているか' do
        expect(page).to have_content 'Agris'
      end
      it 'top_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe "投稿画面のテスト" do
    before do
      visit new_item_path
    end
    context '表示の確認' do
      it 'new_item_pathが"/items/new"であるか' do
        expect(current_path).to eq('/items/new')
      end
      it '(送信)ボタンが表示されているか' do
        expect(page).to have_button "送信"
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        click_button "送信"
        expect(page).to have_current_path customers_path
      end
    end
    
  end
end