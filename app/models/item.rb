class Item < ApplicationRecord
  before_destroy :delete_empty_invoices!

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  def delete_empty_invoices!
    invoices.each do |invoice|
      if invoice.items.count == 1
        InvoiceItem.find_by(id: invoice.id).destroy
        invoice.destroy
      end
    end
  end

  def self.merchant_items(id)
    where(merchant_id: id)
  end
end
