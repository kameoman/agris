# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :customer do
    name { Faker::Lorem.characters(number: 10) }
    kana { Faker::Lorem.characters(number: 10) }
    address { Faker::Lorem.characters(number: 10) }
    phone_number { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
