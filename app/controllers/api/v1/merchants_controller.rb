class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = Merchant.all
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    # if merchant
      render json: MerchantSerializer.new(merchant)
    # else
      #error 404 handling
    # end
  end

end
