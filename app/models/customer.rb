# frozen_string_literal: true

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :admin, optional: true
  has_many :items

  validates :name, presence: true
  validates :kana, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def self.guest
    find_or_create_by!(name: 'ゲスト', kana: 'フリガナ', address: '住所サンプル', phone_number: '08012345678',
                       email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end
  def too_young
    if self.id == 30  #20歳以上の場合
       return "大人です！"
    else  #20歳以下の場合
       return "子供です！"
    end
  end

  # addressを登録した際にgeocoderが緯度、経度のカラムにも自動的に値を入れてくれる
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
