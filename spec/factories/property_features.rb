FactoryBot.define do
  factory :property_feature do
    bed_count { 3 }
    bath_count { 2 }
    carpark { 2 }
    prop_type { "Apartment" }
    plot_size { 13560 }
    association :property
  end
end
