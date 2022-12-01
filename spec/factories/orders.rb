FactoryBot.define do
  factory :order do
    description { |n| "Pedido - #{n}" }
    customer 
  end
end
