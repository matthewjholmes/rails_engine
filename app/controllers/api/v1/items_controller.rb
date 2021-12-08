class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id]
      # if Merchant.exists?(params[:merchant_id])
        items = Item.merchant_items(params[:merchant_id])
        render json: ItemSerializer.new(items)
      # else
      #   #error 404
      # end
    else
      items = Item.all
      render json: ItemSerializer.new(items)
    end
  end

end
