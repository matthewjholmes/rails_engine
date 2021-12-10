require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe 'model methods' do
    it '.merchant_items' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant_id: merchant1.id)
      item2 = create(:item, merchant_id: merchant1.id)
      item3 = create(:item, merchant_id: merchant2.id)

      expect(Item.merchant_items(merchant1.id)).to eq([item1, item2])
    end

    it '#delete_empty_invoices' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      inv_items = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

      expect(Invoice.count).to eq(1)

      item.delete_empty_invoices

      expect(Invoice.count).to eq(0)
    end

    it '.find_items_by_name' do
      item1 = create(:item, name: 'Abc')
      item2 = create(:item, name: 'abc')
      item3 = create(:item, name: 'bca')
      item4 = create(:item, name: 'xyz')

      expect(Item.find_items_by_name('a')).to eq([item1, item2, item3])
    end

    it '.find_items_by_price' do
      item1 = create(:item, unit_price: 1.00)
      item2 = create(:item, unit_price: 2.00)
      item3 = create(:item, unit_price: 3.00)
      item4 = create(:item, unit_price: 4.00)

      expect(Item.find_items_by_price(2, 4)).to eq([item3])
    end
  end


end
