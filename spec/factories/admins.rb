require 'rails_helper'

FactoryBot.define do
  factory :admin do
    email { 'ja@gmail.com' }
    password { 'jajaja' }
    password_confirmation { 'jajaja' }
  end
end
