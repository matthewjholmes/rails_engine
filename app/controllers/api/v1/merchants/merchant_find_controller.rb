# frozen_string_literal: true

module Api
  module V1
    module Merchants
      class MerchantFindController < ApplicationController
        def find
          merchant = Merchant.find_by_name(params[:name])
          # require "pry"; binding.pry
          if merchant != []
            render json: MerchantSerializer.new(merchant[0])

          elsif params[:name].blank?

            render json: { errors: { data: 'Please include a search parameter' } }, status: 400
          else
            render json: MerchantSerializer.no_match(params[:name])

          end
        end
      end
    end
  end
end
