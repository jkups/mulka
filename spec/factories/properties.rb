FactoryBot.define do
  factory :property do
    pid { "PID234" }
    name { "High Point" }
    status { 0 }
    address { "Melbourne, Australia" }
    listing_price { 6500 }
    total_units { 1000 }
    available_units { 1000 }
    minimum_units { 1 }
    description { "My Property" }
    image { "vyi5xafgrugdtuduswio" }
  end
end
