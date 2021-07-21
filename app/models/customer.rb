class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :admin, optional: true
  has_many :items


  validates :name, presence:true
  validates :kana, presence:true
  validates :address, presence:true
  validates :phone_number, presence:true



  def self.guest
    find_or_create_by!(name: 'ゲスト',kana: 'フリガナ',address: '住所サンプル',phone_number: '08012345678',email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end

  # addressを登録した際にgeocoderが緯度、経度のカラムにも自動的に値を入れてくれる
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
