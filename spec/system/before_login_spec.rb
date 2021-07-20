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

  end



end





end