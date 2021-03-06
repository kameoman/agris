# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { 'イチゴ' }
    date { '2021/07/01' }
    send_method { '量販店' }
    count { '1' }
    standard { 'L' }
    customer
  end
end
