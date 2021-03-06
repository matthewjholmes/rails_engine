# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Item merchant endpoint' do
  it 'returns the merchant for an item' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant.count).to eq(1)
    expect(merchant[:data]).to be_a(Hash)
    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data][:type]).to be_a(String)
    expect(merchant[:data][:attributes]).to be_a(Hash)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end

  it 'returns an error if item does not exist' do
    get '/api/v1/items/1/merchant'

    expect(response.status).to eq(404)
  end
end
