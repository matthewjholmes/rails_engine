class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name

  def self.no_match(name)
    { errors: "Could not find Merchant #{name}" }
  end
end
