require 'rails_helper'

RSpec.describe 'Find all items endpoint' do
  it 'returns all items matching a search term' do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id, name: "Salsa")
    item2 = create(:item, merchant_id: merchant.id, name: "Salad")
    item3 = create(:item, merchant_id: merchant.id, name: "Writ of Certiorari")

    get "/api/v1/items/find_all", params: { name: "sal" }

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(2)
  end

  it 'renders a 400 if name param exists and is empty' do
    get "/api/v1/items/find_all", params: { name: "" }

    expect(response.status).to eq(400)
  end

  it 'returns all items under max_price param' do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id, unit_price: 1.00)
    item2 = create(:item, merchant_id: merchant.id, unit_price: 3.00)
    item3 = create(:item, merchant_id: merchant.id, unit_price: 10.00)

    get "/api/v1/items/find_all", params: { max_price: 5.00 }

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(2)
  end

  it 'returns all items over min_price param' do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id, unit_price: 1.00)
    item2 = create(:item, merchant_id: merchant.id, unit_price: 3.00)
    item3 = create(:item, merchant_id: merchant.id, unit_price: 10.00)

    get "/api/v1/items/find_all", params: { min_price: 2.00 }

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(2)
  end

  it 'returns all items between a min and max price' do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id, unit_price: 1.00)
    item2 = create(:item, merchant_id: merchant.id, unit_price: 3.00)
    item3 = create(:item, merchant_id: merchant.id, unit_price: 10.00)

    get "/api/v1/items/find_all", params: { min_price: 2.00, max_price: 5.00 }

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].count).to eq(1)
  end

  it 'returns a 400 if params include both name and price' do
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id, unit_price: 1.00, name: "Salsa")
    item2 = create(:item, merchant_id: merchant.id, unit_price: 3.00)
    item3 = create(:item, merchant_id: merchant.id, unit_price: 10.00)

    get "/api/v1/items/find_all", params: { name: "Salsa", max_price: 2.00 }

    expect(response.status).to eq(400)
  end
end
