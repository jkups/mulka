Buyer.destroy_all
BuyerApp::Tranzaction.destroy_all
BuyerApp::Portfolio.destroy_all
SellerApp::PropertyFeature.destroy_all
SellerApp::Property.destroy_all

PROPERTY_TYPE = ["Apartment", "Terrace", "House"].freeze
PROPERTY_IMAGE = [
  "na8vluep3ak42mhnbnj1",
  "qgaacrsaccdesfbhix5i",
  "gkjnuyskk7dctedu8odl"
]

buyer = Buyer.create!(
  full_name: "Jane Smith",
  preferred_name: "Jane",
  email: "jane@example.com",
  password: "password",
  password_confirmation: "password"
)
p "buyer was successfully created"

organization = SellerApp::Organization.create!(
  name: "Wulo",
  address: Faker::Address.full_address,
  suburb: Faker::Address.zip_code,
  city: Faker::Address.city,
  country: Faker::Address.country,
  registration_number: "123456"
)
p "organization was successfully created"

portfolio = BuyerApp::Portfolio.create!(
  name: "Default",
  number: Faker::Number.number(digits: 8),
  buyer: buyer,
  active: true
)
p "portfolio was sucessfully created"

def generate_offer(property, total_units = 1000, status = Offer.statuses.fetch(:active))
  Offer.create!(
    property: property,
    total_units: total_units,
    minimum_units: 1,
    available_units: total_units,
    price: 500_000,
    status: status
  )
end

def generate_external_reference
  BuyerApp::ExternalReference.create(
    referenceable_source: "paypal",
    referenceable_id: Faker::Number.number(digits: 8)
  )
end

def generate_property_features(property)
  SellerApp::PropertyFeature.create!(
    property: property,
    bed: (1..4).to_a.sample,
    bath: (1..3).to_a.sample,
    parking: (1..2).to_a.sample,
    plot_size: (3000..3500).to_a.sample,
    floor_size: (2300..2800).to_a.sample
  )
end

3.times do |idx|
  property = SellerApp::Property.create!(
    pid: "PID" + (rand * 1000).round.to_s,
    name: Faker::Restaurant.name,
    address: Faker::Address.full_address,
    suburb: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: Faker::Address.country,
    description: Faker::Restaurant.description,
    image: PROPERTY_IMAGE[idx],
    occupied: false,
    category: "Town House",
    classification: SellerApp::Property.classifications.fetch(:newly_built),
    organization: organization
  )

  generate_property_features(property)
  offer = generate_offer(property)

  2.times do
    unit_price = offer.price / offer.total_units
    units_to_acquire = Faker::Number.within(range: 1..10)
    amount = unit_price * units_to_acquire

    BuyerApp::Tranzaction.create!(
      units: units_to_acquire,
      amount: amount,
      fee: amount * 0.1,
      offer: offer,
      portfolio: portfolio,
      external_reference: generate_external_reference
    )
  end
end

p "properties, offers and tranzactions were successfully created"

property_manager = PropertyManager.create!(
  full_name: Faker::Name.name,
  mobile: Faker::PhoneNumber.phone_number,
  email: ["one@example.com", "two@example.com"].sample,
  company_name: Faker::Company.name
)

p "property manager was successfully created"

property_to_be_settled = SellerApp::Property.create!(
  pid: "PID" + (rand * 1000).round.to_s,
  name: Faker::Restaurant.name,
  address: Faker::Address.full_address,
  suburb: Faker::Address.zip_code,
  city: Faker::Address.city,
  country: Faker::Address.country,
  description: Faker::Restaurant.description,
  image: "vyi5xafgrugdtuduswio",
  occupied: false,
  category: "House",
  classification: SellerApp::Property.classifications.fetch(:newly_built),
  organization: organization
)

generate_property_features(property_to_be_settled)
offer = generate_offer(property_to_be_settled, 6, Offer.statuses.fetch(:sold_out))

3.times do
  unit_price = offer.price / offer.total_units
  units_to_acquire = 2
  amount = unit_price * units_to_acquire

  BuyerApp::Tranzaction.create!(
    units: units_to_acquire,
    amount: amount,
    fee: amount * 0.1,
    offer: offer,
    portfolio: portfolio,
    external_reference: generate_external_reference
  )
end

settled_property = SettledProperty.create!(
  property: property_to_be_settled,
  property_manager: property_manager,
  monthly_rent: 16972,
  lease_start_on: Date.today - 8.months,
  lease_end_on: Date.today + 4.months,
  lease_term: "Annual",
  status: SettledProperty.statuses.fetch(:occupied)
)

p "settled properties with corresponding offers and tranzactions were successfully created"

12.downto(1) do |i|
  date = Date.today - (i * 6.months)
  PropertyValuation.create!(
    settled_property: settled_property,
    date: date,
    estimate: [350000, 450000, 480000, 550000, 500000, 650000, 620000, 600000, 720000].sample
  )
end

p "property valuation was successfully created"

8.downto(1) do |i|
  date = Date.today - i.months
  PropertyRent.create!(
    settled_property: settled_property,
    date: date,
    description: "Rent for the month of #{date.month}.",
    amount: 16972
  )
end

p "property rent was successfully created"

3.downto(1) do |i|
  date = Date.today - i * 2.months
  PropertyExpense.create!(
    settled_property: settled_property,
    date: date,
    description: Faker::Lorem.sentence,
    amount: Faker::Number.number(digits: 4)
  )
end

p "property expense was successfully created"
