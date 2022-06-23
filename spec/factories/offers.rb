FactoryBot.define do
  factory :offer do
    property { nil }
    total_units { 1 }
    minimum_units { 1 }
    available_units { 1 }
    price { "9.99" }
    status { 1 }
  end
end
