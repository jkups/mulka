Transaction.destroy_all
PropertyFeature.destroy_all
Property.destroy_all
Account.destroy_all
User.destroy_all

PROPERTY_TYPE = ["Apartment", "Terrace", "House"].freeze
PROPERTY_IMAGE = [
  "na8vluep3ak42mhnbnj1",
  "qgaacrsaccdesfbhix5i",
  "gkjnuyskk7dctedu8odl",
  "vyi5xafgrugdtuduswio"
]

user = User.create!(
  email: "one@example.com",
  password: "password",
  password_confirmation: "password"
)
p "user was successfully created"

3.times do |idx|
  property = Property.create!(
    pid: "PID" + (rand * 1000).round.to_s,
    status: 1,
    name: Faker::Restaurant.name,
    address: Faker::Address.full_address,
    listing_price: Faker::Number.number(digits: 6),
    total_units: 1000,
    available_units: 1000,
    minimum_units: 1,
    description: Faker::Restaurant.description,
    image: PROPERTY_IMAGE[idx]
  )

  PropertyFeature.create!(
    property: property,
    bed_count: (1..4).to_a.sample,
    bath_count: (1..3).to_a.sample,
    carpark: (1..2).to_a.sample,
    plot_size: 3500,
    prop_type: PROPERTY_TYPE.sample
  )

  2.times do
    unit_price = property.listing_price / property.total_units
    units_to_acquire = Faker::Number.within(range: 1..10)
    value = unit_price * units_to_acquire

    Transaction.create!(
      units: units_to_acquire,
      value: value,
      fee: value * 0.1,
      trxn_number: Faker::Number.number(digits: 6),
      property: property,
      user: user,
      status: Transaction.statuses.fetch(:confirmed)
    )
  end
end

p "properties and trasacntions were successfully created"

Account.create!(
  name: "Diamond",
  number: Faker::Number.number(digits: 8),
  user: user
)
p "account was sucessfully created"
