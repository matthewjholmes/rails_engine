class Merchant < ApplicationRecord

  has_many :items

  def self.find_by_name(name)
    # require "pry"; binding.pry
    where('name like ?', "%#{name}%")
      .order(:name)
      .limit(1)
  end
end
