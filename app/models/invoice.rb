# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  # def self.delete_empty!
  #   joins(:invoice_items)
  #   .having('COUNT(invoice_items.id) = 1')
  #   .group(:id)
  #   .destroy_all
  # end
end
