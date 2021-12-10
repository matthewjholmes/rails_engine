# frozen_string_literal: true

module Api
  module V1
    module Items
      class ItemFindController < ApplicationController
        def find_all
          items_by_name = Item.find_items_by_name(params[:name])
          items_by_price = Item.find_items_by_price(params[:min_price], params[:max_price])
          if params[:name] && (!params[:min_price] && !params[:max_price])
            if params[:name].empty? == false
              render json: ItemSerializer.new(items_by_name)
            else
              render json: { errors: 'Please include a search term' }, status: 400
            end
          elsif !params[:name] && (params[:min_price] || params[:max_price])
            render json: ItemSerializer.new(items_by_price)
          else
            render json: { errors: 'Please include valid search terms' }, status: 400
          end
        end
      end
    end
  end
end
