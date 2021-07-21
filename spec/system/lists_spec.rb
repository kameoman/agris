# frozen_string_literal: true

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
end

describe Customer do
  describe '#create' do
    it '項目全てが存在すれば登録できること' do
      customer = Customer.new(name: '見本', kana: 'フリガナ', address: '東京都千代田区', phone_number: '08000001111', email: 'kame@gmail.com', password: '112233', password_confirmation: '112233')
      expect(customer).to be_valid
    end

    it'名前が無い場合は登録できない' do
      customer = Customer.new(name: '', kana: 'フリガナ', address: '東京都千代田区', phone_number: '08000001111', email: 'kame@gmail.com', password: '112233', password_confirmation: '112233')
      customer.valid?
      expect(customer.errors[:name]).to have_content 'を入力してください'
    end

    it'名前が無い場合は登録できない' do
      customer = Customer.new(name: '', kana: 'フリガナ', address: '東京都千代田区', phone_number: '08000001111', email: '', password: '112233', password_confirmation: '112233')
      customer.valid?
      expect(customer.errors[:email]).to have_content 'を入力してください'
    end

    it'名前が無い場合は登録できない' do
      customer = Customer.new(name: '', kana: '', address: '東京都千代田区', phone_number: '08000001111', email: '', password: '112233', password_confirmation: '112233')
      customer.valid?
      expect(customer.errors[:kana]).to have_content 'を入力してください'
    end

    it'名前が無い場合は登録できない' do
      customer = Customer.new(name: '', kana: 'フリガナ', address: '', phone_number: '08000001111', email: '', password: '112233', password_confirmation: '112233')
      customer.valid?
      expect(customer.errors[:address]).to have_content 'を入力してください'
    end
  end

  describe 'ユーザーログイン' do
    before do
      visit new_customer_session_path
    end
  end
end
