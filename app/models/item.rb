# frozen_string_literal: true

class Item < ApplicationRecord
  enum send_method: { その他: 0, 量販店: 1, 学校給食: 2, 部会: 3, 贈答: 4, 直売所: 5 }
  belongs_to :customer, optional: true
  belongs_to :admin, optional: true
  has_many :tags

  validates :name, presence: true
  validates :date, presence: true
  validates :send_method, presence: true
  validates :count, presence: true
  validates :standard, presence: true

  attachment :image
end
