require 'rails_helper'

RSpec.describe 'Update item endpoint' do
  it 'can edit an item' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    previous_name = Item.last.name

    patch "/api/v1/items/#{item.id}", params: { item: {name: "Widget"} }
    item = Item.find(item.id)

    expect(response).to be_successful
    expect(item.name).to eq("Widget")
  end

  it 'cannot update an invalid item' do
    patch "/api/v1/items/1", params: { item: {name: "Spindrift"} }

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end
