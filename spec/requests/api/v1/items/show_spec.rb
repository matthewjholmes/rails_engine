# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Item show endpoint' do
  it 'returns an item' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item).to have_key(:data)
    expect(item[:data]).to be_a(Hash)

    expect(item[:data][:id]).to be_a(String)
    expect(item[:data][:type]).to be_a(String)
    expect(item[:data][:attributes]).to be_a(Hash)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'returns a 404 if id not valid' do
    get '/api/v1/items/1'

    expect(response.status).to eq(404)
  end
end
