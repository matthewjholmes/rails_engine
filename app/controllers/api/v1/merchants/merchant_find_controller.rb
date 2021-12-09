class Api::V1::Merchants::MerchantFindController < ApplicationController

  def find
    merchant = Merchant.find_by_name(params[:name])
    # require "pry"; binding.pry
    if merchant != []
      render json: MerchantSerializer.new(merchant[0])
    else
      render json: MerchantSerializer.no_match(params[:name]), status: 400
    end
  end
end
