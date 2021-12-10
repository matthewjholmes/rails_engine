# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        if params[:merchant_id]
          if Merchant.exists?(params[:merchant_id])
            items = Item.merchant_items(params[:merchant_id])
            render json: ItemSerializer.new(items)
          else
            render json: { errors: "Could not find Merchant #{params[:merchant_id]}" }, status: 404
          end
        else
          items = Item.all
          render json: ItemSerializer.new(items)
        end
      end

      def show
        item = Item.find(params[:id])
        render json: ItemSerializer.new(item)
      end

      def create
        item = Item.create!(item_params)
        render json: ItemSerializer.new(item), status: 201
      end

      def update
        item = Item.find(params[:id])
        item.update!(item_params)
        render json: ItemSerializer.new(item)
      end

      def destroy
        item = Item.find(params[:id])
        item.destroy
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end
