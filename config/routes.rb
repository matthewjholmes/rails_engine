# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', controller: :merchant_find, action: :find
      end
      namespace :items do
        get '/find_all', controller: :item_find, action: :find_all
      end
      resources :merchants, only: %i[index show] do
        resources :items, only: :index
      end

      # get '/merchants/find', to: 'merchant_find#find'

      resources :items do
        get '/merchant', controller: :item_merchants, action: :show
      end
    end
  end
end
