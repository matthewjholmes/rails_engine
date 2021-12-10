# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'model methods' do
    it '.find_by_name' do
      merchant1 = create(:merchant, name: 'Abc')
      merchant2 = create(:merchant, name: 'bca')
      merchant3 = create(:merchant, name: 'Xyz')

      expect(Merchant.find_by_name('a')).to eq([merchant1])
    end
  end
end
