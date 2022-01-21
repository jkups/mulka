FactoryBot.define do
  factory :transaction do
    units { 1 }
    value { 1500 }
    fee { 150 }
    trxn_number { "23455" }
    association :property
    association :user
  end
end
