PROPERTY_TYPE = ["Apartment", "Terrace", "House"].freeze
PROPERTY_IMAGE = [
  "na8vluep3ak42mhnbnj1",
  "qgaacrsaccdesfbhix5i",
  "gkjnuyskk7dctedu8odl"
]

liaison = Admin.create!(
  full_name: "Ashley Tray",
  email: "ashley@example.com",
  password: "password",
  password_confirmation: "password"
)

buyer = Buyer.create!(
  full_name: "Jane Smith",
  preferred_name: "Jane",
  email: "jane@example.com",
  password: "password",
  password_confirmation: "password"
)
p "buyer was successfully created"

organization = Organizations::Organization.create!(
  name: "Wulo",
  address: Faker::Address.full_address,
  suburb: Faker::Address.zip_code,
  city: Faker::Address.city,
  country: Faker::Address.country,
  registration_number: "123456"
)
p "organization was successfully created"

seller = Seller.create!(
  full_name: "Honey Raymond",
  email: "honey@example.com",
  organization: organization,
  password: "password",
  password_confirmation: "password"
)
p "seller was successfully created"

portfolio = Portfolios::Portfolio.create!(
  name: "Default",
  number: Faker::Number.number(digits: 8),
  buyer: buyer,
  active: true
)
p "portfolio was sucessfully created"

def generate_offer(property, total_units: 1000, status: Tranzactions::Offer.statuses.fetch(:active))
  Tranzactions::Offer.create!(
    property: property,
    total_units: total_units,
    minimum_units: 1,
    available_units: total_units,
    price: 500_000,
    status: status
  )
end

def generate_external_reference
  Tranzactions::ExternalReference.create(
    referenceable_source: "paypal",
    referenceable_id: Faker::Number.number(digits: 8)
  )
end

def generate_property_features(property)
  Properties::PropertyFeature.create!(
    property: property,
    bed: (1..4).to_a.sample,
    bath: (1..3).to_a.sample,
    parking: (1..2).to_a.sample,
    plot_size: (3000..3500).to_a.sample,
    floor_size: (2300..2800).to_a.sample
  )
end

3.times do |idx|
  property = Properties::Property.create!(
    pid: "PID" + (rand * 1000).round.to_s,
    name: Faker::Restaurant.name,
    address: Faker::Address.full_address,
    suburb: Faker::Address.zip_code,
    subdivision: "VIC",
    country_code: "AU",
    description: Faker::Restaurant.description,
    images: PROPERTY_IMAGE[idx],
    occupied: false,
    category: Properties::Property::CATEGORIES.fetch(:town_house),
    classification: Properties::Property::CLASSIFICATIONS.fetch(:newly_built),
    organization: organization,
    owner: seller
  )

  generate_property_features(property)
  offer = generate_offer(property)

  2.times do
    unit_price = offer.price / offer.total_units
    units_to_acquire = Faker::Number.within(range: 1..10)
    amount = unit_price * units_to_acquire

    Tranzactions::Tranzaction.create!(
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

property_manager = Properties::PropertyManager.create!(
  full_name: Faker::Name.name,
  mobile: Faker::PhoneNumber.phone_number,
  email: ["one@example.com", "two@example.com"].sample,
  company_name: Faker::Company.name
)

p "property manager was successfully created"

property_to_be_settled = Properties::Property.create!(
  pid: "PID" + (rand * 1000).round.to_s,
  name: Faker::Restaurant.name,
  address: Faker::Address.full_address,
  suburb: Faker::Address.zip_code,
  subdivision: "VIC",
  country_code: "AU",
  description: Faker::Restaurant.description,
  images: "vyi5xafgrugdtuduswio",
  occupied: false,
  category: Properties::Property::CATEGORIES.fetch(:house),
  classification: Properties::Property::CLASSIFICATIONS.fetch(:newly_built),
  organization: organization,
  owner: seller
)

generate_property_features(property_to_be_settled)
settled_property_offer = generate_offer(property_to_be_settled, total_units: 6, status: Tranzactions::Offer.statuses.fetch(:sold_out))

3.times do
  unit_price = settled_property_offer.price / settled_property_offer.total_units
  units_to_acquire = 2
  amount = unit_price * units_to_acquire

  Tranzactions::Tranzaction.create!(
    units: units_to_acquire,
    amount: amount,
    fee: amount * 0.1,
    offer: settled_property_offer,
    portfolio: portfolio,
    external_reference: generate_external_reference
  )
end

settled_property = Properties::SettledProperty.create!(
  property: property_to_be_settled,
  property_manager: property_manager,
  liaison: liaison,
  monthly_rent: 16972,
  lease_start_on: Date.today - 8.months,
  lease_end_on: Date.today + 4.months,
  lease_term: "Annual",
  status: Properties::SettledProperty.statuses.fetch(:occupied)
)

Portfolios::PortfolioSettledProperty.create(
  portfolio: portfolio,
  settled_property: settled_property,
  units: 6
)

p "settled properties with corresponding offers and tranzactions were successfully created"

12.downto(1) do |i|
  date = Date.today - (i * 6.months)
  Properties::PropertyValuation.create!(
    settled_property: settled_property,
    date: date,
    estimate: [350000, 450000, 480000, 550000, 500000, 650000, 620000, 600000, 720000].sample
  )
end

p "property valuation was successfully created"

8.downto(1) do |i|
  date = Date.today - i.months
  Properties::PropertyRent.create!(
    settled_property: settled_property,
    date: date,
    description: "Rent for the month of #{Date::MONTHNAMES[date.month]}.",
    amount: 1697
  )
end

p "property rent was successfully created"

3.downto(1) do |i|
  date = Date.today - i * 2.months
  Properties::PropertyExpense.create!(
    settled_property: settled_property,
    date: date,
    description: Faker::Lorem.sentence,
    amount: Faker::Number.number(digits: 3)
  )
end

p "property expense was successfully created"

eoi_property = Properties::Property.create!(
  pid: "PID" + (rand * 1000).round.to_s,
  name: Faker::Restaurant.name,
  address: Faker::Address.full_address,
  suburb: Faker::Address.zip_code,
  subdivision: "NSW",
  country_code: "AU",
  description: Faker::Restaurant.description,
  images: "jlsvt4sms9ymprcrljjy,gkjnuyskk7dctedu8odl,jlsvt4sms9ymprcrljjy",
  occupied: false,
  category: Properties::Property::CATEGORIES.fetch(:house),
  classification: Properties::Property::CLASSIFICATIONS.fetch(:newly_built),
  organization: organization,
  owner: seller
)

generate_property_features(eoi_property)
offer = generate_offer(eoi_property, total_units: 500, status: Tranzactions::Offer.statuses.fetch(:expression_of_interest))

p "eoi property and corresponding offer was successfully created"

Tranzactions::ExpressionOfInterest.create!(
  offer: offer,
  buyer: buyer,
  units: 10
)

p "eoi was successfully created"
