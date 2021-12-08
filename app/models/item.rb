class Item < ApplicationRecord

  def self.merchant_items(id)
    where(merchant_id: id)
  end
end
