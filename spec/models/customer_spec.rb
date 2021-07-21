# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'モデルのテスト' do
    it '有効なcustomerの場合は保存されるか' do
      expect(build(:customer)).to be_valid
    end
  end
end
