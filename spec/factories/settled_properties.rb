FactoryBot.define do
  factory :settled_property do
    property { nil }
    property_manager { nil }
    status { 1 }
    monthly_rent { "9.99" }
    lease_start_on { "2022-06-21 18:56:59" }
    lease_end_on { "2022-06-21 18:56:59" }
    lease_term { "MyString" }
  end
end
