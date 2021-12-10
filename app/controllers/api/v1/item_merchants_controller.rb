# frozen_string_literal: true

module Api
  module V1
    class ItemMerchantsController < ApplicationController
      def show
        item = Item.find(params[:item_id])
        merchant = Merchant.find(item.merchant.id)
        render json: MerchantSerializer.new(merchant)
      end
    end
  end
end
