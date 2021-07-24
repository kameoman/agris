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
  end

  describe '投稿画面のテスト' do
      before do
        visit new_item_path
      end

      it 'URLが正しい' do
        expect(current_path).to eq '/items/new'
      end

      context '投稿成功のテスト' do
        before do
          fill_in 'item[name]', with: item.name
          fill_in 'item[standard]', with: item.standard
          fill_in 'item[count]', with: item.count
          fill_in 'item[date]', with: item.date
        end

        it '自分の新しい投稿が正しく保存される' do
          expect { click_button 'commit' }.to change(customer.items, :count).by(1)
        end
        it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
          click_button 'commit'
          expect(current_path).to eq '/customers/' + Customer.last.id.to_s
        end
        it '詳細画面のモーダル表示が表示されるか' do
          click_button 'commit'
          expect(page).to have_content'詳細'
        end
        it '「詳細」が表示される' do
          click_button 'commit'
          expect(current_path).to eq '/customers/' + Customer.last.id.to_s
          expect(page).to have_content '詳細'
        end
        it '「編集」が表示される' do
          click_button 'commit'
          expect(current_path).to eq '/customers/' + Customer.last.id.to_s
          expect(page).to have_content '編集'
        end
        it '「テストで投稿した内容」が表示される' do
          click_button 'commit'
          expect(page).to have_content 'イチゴ'
        end
        it '「テストで投稿した内容」が表示される' do
          click_button 'commit'
          expect(page).to have_content 'L'
        end
        it '「テストで投稿した内容」が表示される' do
          click_button 'commit'
          expect(page).to have_content '量販店'
        end

        # xit '「編集遷移後」正しく表示される' do
        #   click_button 'commit'
        #   find_link('編集').click
        #   expect(page).to have_content '投稿データの編集'
        # end
        it '「削除」が表示される' do
          click_button 'commit'
          expect(current_path).to eq '/customers/' + Customer.last.id.to_s
          expect(page).to have_content '削除'
        end
        it '「出荷データ」が表示される' do
          click_button 'commit'
          expect(current_path).to eq '/customers/' + Customer.last.id.to_s
          expect(page).to have_content '出荷データ'
        end
        it '「品目別出荷割合(グラフ)」が表示される' do
          click_button 'commit'
          expect(current_path).to eq '/customers/' + Customer.last.id.to_s
          expect(page).to have_css("#stage")
        end
        # 以下別方法で記述記録のため残す（seleniumの作動不具合)
        # xit '「削除」が表示される' do
        #   click_button 'commit'
        #   find_link('削除').click
        #   page.driver.browser.switch_to.alert.accept
        #   expect(item).where(id: item.id).to eq 0
        # end
    end

      it '一覧画面へ戻る選択ボタンがあり、遷移先も正しい' do
        click_on '一覧画面へ戻る'
        expect(current_path).to eq '/customers/' + Customer.last.id.to_s
      end


  # ↓投稿後
  end


end

describe '[STEP3 管理者ログイン後のテスト' do
    let(:admin) { create(:admin) }
    let(:customer) { create(:customer) }

    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'commit'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/customers_profile'
      end
      
      it '「圃場検索機能」が表示される' do
        expect(page).to have_content '圃場検索'
      end
      it '「ユーザー検索機能」が表示される' do
        expect(page).to have_content 'ユーザー検索'
      end
      it '「登録生産者一覧」が表示される' do
        expect(page).to have_content '登録生産者一覧'
      end
      
    end


  end