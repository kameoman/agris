# frozen_string_literal: true

require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:customer) { create(:customer) }
  let(:item) { create(:item, customer: customer) }

  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'commit'
  end

  describe 'ヘッダーのテスト：　ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it '使い方リンクが表示される: 左上から1番目のリンクが使い方である' do
        customers_link = find_all('a')[1].native.inner_text
        customers_link = customers_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link customers_link
        is_expected.to eq '/customers/1/my_page'
      end
      it '使い方リンクが表示される: 左上から2番目のリンクが出荷履歴一覧である' do
        customers_link = find_all('a')[2].native.inner_text
        customers_link = customers_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link customers_link
        is_expected.to eq '/customers/1'
      end
      it '使い方リンクが表示される: 左上から3番目のリンクが新規登録である' do
        customers_link = find_all('a')[3].native.inner_text
        customers_link = customers_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link customers_link
        is_expected.to eq '/items/new'
      end
    end
  end

  describe '出荷履歴一覧のテスト' do
    before do
      visit customer_path(1)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/1'
      end
      it 'タイトル「月別リスト」が表示される' do
        expect(page).to have_content '月別リスト'
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'item[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'item[date]', with: '2021/07'
        fill_in 'item[send_method]'
        fill_in 'item[count]'
        fill_in 'item[standard]'
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button 'Create Book' }.to change(user.books, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button 'Create Book'
        expect(current_path).to eq '/books/' + Book.last.id.to_s
      end
    end
  end
end
