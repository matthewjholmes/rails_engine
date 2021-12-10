require 'rails_helper'

RSpec.describe 'Find merchant endpoint' do
  it 'can return one merchant from search params' do
    merchant1 = create(:merchant, name: "Alpha and Omega")
    merchant2 = create(:merchant, name: "Antidisestablishmentarianism")
    merchant3 = create(:merchant, name: "Abracadbra")

    get '/api/v1/merchants/find', params: { name: "A" }

    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant.count).to eq(1)
    expect(merchant[:data]).to be_a(Hash)
    expect(merchant[:data][:id]).to be_a(String)
    expect(merchant[:data][:type]).to be_a(String)
    expect(merchant[:data][:attributes]).to be_a(Hash)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
    expect(merchant[:data][:attributes][:name]).to eq("Abracadbra")
  end

  it 'raises a 400 error if params are missing' do
    get '/api/v1/merchants/find', params: { name: "" }

    expect(response.status).to eq(400)
  end

  it 'returns nil attributes if no merchant is found' do
    get '/api/v1/merchants/find', params: { name: "C" }

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:errors]).to eq("Could not find Merchant C")
  end
end
