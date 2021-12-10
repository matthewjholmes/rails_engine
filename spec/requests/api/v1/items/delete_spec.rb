# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Delete item endpoint' do
  it 'can delete an item' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(Item.count).to eq(0)
  end

  it 'can delete associated invoices if only item on invoice' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    expect(Item.count).to eq(1)
    expect(Invoice.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect(Invoice.count).to eq(0)
  end
end
