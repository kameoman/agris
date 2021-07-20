require "rails_helper"

describe'ユーザーログイン前のテスト'do
  describe'トップ画面のテスト'do
    before do
      visit root_path
    end

    context '表示内容の確認'do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ログインのリンクが表示されているか'do
        log_in_link = find_all('a')[4].native.inner_text
        expect(log_in_link).to match('ログイン')
      end
      it 'ログインボタンの遷移先が正しい'do
        log_in_link = find_all('a')[4].native.inner_text
        expect(page).to have_link 'ログイン', href: new_customer_session_path
      end
      it '新規登録のリンクが表示されているか'do
        sign_up_link = find_all('a')[3].native.inner_text
        expect(sign_up_link).to match('新規登録')
      end
      it '新規登録ボタンの遷移先が正しい'do
        sign_up_link = find_all('a')[3].native.inner_text
        expect(page).to have_link '新規登録', href: new_customer_registration_path
      end
      it '管理者ログインのリンクが表示されているか'do
        log_in_link = find_all('a')[5].native.inner_text
        expect(log_in_link).to match('管理者ログイン')
      end
      it '管理者ログインボタンの遷移先が正しい'do
        log_in_link = find_all('a')[5].native.inner_text
        expect(page).to have_link '管理者ログイン', href: new_admin_session_path
      end
      it '使い方のリンクが表示されているか'do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match('使い方')
      end
      it '使い方の遷移先が正しい'do
        about_link = find_all('a')[1].native.inner_text
        expect(page).to have_link '使い方', href: home_about_path
      end
    end

    describe 'アバウト画面のテスト' do
      before do
        visit '/home/about'
      end

      context '表示内容の確認' do
        it '使い方のURLが正しく表示されている'do
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

    context 'リンクの内容を確認'do
      subject{ current_path }

      it '使い方を押すと、使い方画面に遷移する'do
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




  end





end