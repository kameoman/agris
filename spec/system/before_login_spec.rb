# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ログインのリンクが表示されているか' do
        log_in_link = find_all('a')[4].native.inner_text
        expect(log_in_link).to match('ログイン')
      end
      it 'ログインボタンの遷移先が正しい' do
        log_in_link = find_all('a')[4].native.inner_text
        expect(page).to have_link 'ログイン', href: new_customer_session_path
      end
      it '新規登録のリンクが表示されているか' do
        sign_up_link = find_all('a')[3].native.inner_text
        expect(sign_up_link).to match('新規登録')
      end
      it '新規登録ボタンの遷移先が正しい' do
        sign_up_link = find_all('a')[3].native.inner_text
        expect(page).to have_link '新規登録', href: new_customer_registration_path
      end
      it '管理者ログインのリンクが表示されているか' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(log_in_link).to match('管理者ログイン')
      end
      it '管理者ログインボタンの遷移先が正しい' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(page).to have_link '管理者ログイン', href: new_admin_session_path
      end
      it '使い方のリンクが表示されているか' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match('使い方')
      end
      it '使い方の遷移先が正しい' do
        about_link = find_all('a')[1].native.inner_text
        expect(page).to have_link '使い方', href: home_about_path
      end
    end

    describe 'アバウト画面のテスト' do
      before do
        visit '/home/about'
      end

      context '表示内容の確認' do
        it '使い方のURLが正しく表示されている' do
          expect(current_path).to eq '/home/about'
        end
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'Agris'
      end

      it '使い方リンクが表示される: 左上から1番目のリンクが使い方である' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match('使い方')
      end
      it '新規登録リンクが表示される: 左上から3番目のリンクが使い方である' do
        sign_up_link = find_all('a')[3].native.inner_text
        expect(sign_up_link).to match('新規登録')
      end
      it 'ログインリンクが表示される: 左上から4番目のリンクが使い方である' do
        sign_in_link = find_all('a')[4].native.inner_text
        expect(sign_in_link).to match('ログイン')
      end
      it '使い方リンクが表示される: 左上から5番目のリンクが使い方である' do
        sign_in_link = find_all('a')[5].native.inner_text
        expect(sign_in_link).to match('管理者ログイン')
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it '使い方を押すと、使い方画面に遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/home/about'
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[3].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq '/customers/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[4].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/customers/sign_in'
      end
      it '管理者ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[5].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/admins/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_customer_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_up'
      end
      it '「Sign up」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'customer[name]'
      end
      it 'kanaフォームが表示される' do
        expect(page).to have_field 'customer[kana]'
      end
      it '生産者番号のフォームが表示される' do
        expect(page).to have_field 'customer[customer_no]'
      end
      it '電話番号のフォームが表示される' do
        expect(page).to have_field 'customer[phone_number]'
      end
      it '住所のフォームが表示される' do
        expect(page).to have_field 'customer[address]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it '登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'customer[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[kana]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[address]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[phone_number]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
      end

      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button 'commit'
        expect(current_path).to eq '/customers/' + Customer.last.id.to_s
      end
    end
  end

  describe 'ユーザーログイン' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_in'
      end
      it 'タイトルに「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it '「ログインする」と表示される' do
        expect(page).to have_button 'ログインする'
      end
      it 'メールアドレスのフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'パスワードのフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'nameフォームは表示されない' do
        expect(page).not_to have_field 'customer[name]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'commit'
      end

      it 'ログイン後の遷移先が、ログインした状態になっている' do
        expect(current_path).to eq '/customers/' + customer.id.to_s
      end
      it 'ログイン後の遷移先が、ログインした状態になっている' do
        find_link('マイページ').click
        expect(current_path).to eq '/customers/' + customer.id.to_s + '/my_page'
      end
      it 'ログイン後、マイページに移動し、表示確認' do
        find_link('マイページ').click
        expect(page).to have_content 'さんの会員情報'
      end
      it 'ログイン後、マイページに移動し、削除ボタンの表示確認' do
        find_link('マイページ').click
        expect(page).to have_content 'アカウントを削除する'
      end
      it 'ログイン後、マイページに移動し、削除機能が作動するか確認' do
        find_link('マイページ').click
        find_link('削除').click
        expect(Customer.where(id: customer.id).count).to eq 0
      end
      it 'ログイン後、マイページに移動し、削除後の遷移先が正しいかどうかの確認' do
        find_link('マイページ').click
        find_link('削除').click
        expect(current_path).to eq '/'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[email]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'commit'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end

      it '会員情報が直接入力されて削除されないこと' do
        destroy_customer_path(customer.id)
        expect(Customer.where(id: customer.id).count).to eq 1
      end
      it 'URLログイン前に直打ちでも遷移できないようにする' do
        destroy_customer_path(customer.id)
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'commit'
    end

    context 'ヘッダーの表示を確認' do
      it '使い方リンクが表示される: 左上から1番目のリンクが使い方である' do
        customers_link = find_all('a')[1].native.inner_text
        expect(customers_link).to match('マイページ')
      end
      it '使い方リンクが表示される: 左上から2番目のリンクが使い方である' do
        customers_link = find_all('a')[2].native.inner_text
        expect(customers_link).to match('出荷履歴一覧')
      end
      it '使い方リンクが表示される: 左上から3番目のリンクが使い方である' do
        customers_link = find_all('a')[3].native.inner_text
        expect(customers_link).to match('新規登録')
      end
      it '使い方リンクが表示される: 左上から4番目のリンクが使い方である' do
        customers_link = find_all('a')[4].native.inner_text
        expect(customers_link).to match('ログアウト')
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'commit'
      logout_link = find_all('a')[4].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/home/about'
      end

      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end

describe '管理者ログイン等の確認' do
  let(:admin) { create(:admin) }
  before do
    visit new_admin_session_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/admins/sign_in'
    end
    it 'タイトルに「ログイン」と表示される' do
      expect(page).to have_content '管理者ログイン'
    end
    it '「ログインする」と表示される' do
      expect(page).to have_button 'ログインする'
    end
    it 'メールアドレスのフォームが表示される' do
      expect(page).to have_field 'admin[email]'
    end
    it 'パスワードのフォームが表示される' do
      expect(page).to have_field 'admin[password]'
    end
    it 'nameフォームは表示されない' do
      expect(page).not_to have_field 'admin[name]'
    end
  end

  context '管理者ログイン成功のテスト' do
    before do
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
    end

    it 'ログイン後の遷移先が、正しい' do
      click_button 'commit'
      expect(current_path).to eq '/admin/customers_profile'
    end
  end

  context 'ログイン失敗のテスト' do
    before do
      fill_in 'admin[email]', with: ''
      fill_in 'admin[password]', with: ''
      click_button 'commit'
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
      expect(current_path).to eq '/admins/sign_in'
    end
  end

  describe 'ヘッダーのテスト: 管理者ログインしている場合' do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'commit'
    end

    it 'タイトルが表示される' do
      expect(page).to have_content '登録生産者一覧'
    end

    context 'ヘッダーの表示を確認' do
      it 'Usersリンクが表示される: 左上から2番目のリンクが「Users」である' do
        users_link = find_all('a')[1].native.inner_text
        expect(users_link).to match('会員一覧')
      end
      it 'Usersリンクが表示される: 左上から2番目のリンクが「Users」である' do
        users_link = find_all('a')[2].native.inner_text
        expect(users_link).to match('出荷全履歴一覧')
      end
      it 'Usersリンクが表示される: 左上から2番目のリンクが「Users」である' do
        users_link = find_all('a')[3].native.inner_text
        expect(users_link).to match('ログアウト')
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:admin) { create(:admin) }

    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'commit'
      logout_link = find_all('a')[3].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/home/about'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
