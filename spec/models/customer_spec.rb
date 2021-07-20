require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "create" do
    before do
     @customer = FactoryBot.build(:customer)
    end
  end
  
  
end
