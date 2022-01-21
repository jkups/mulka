FactoryBot.define do
  factory :account do
    account_name { "Golden Age" }
    account_number { "234234235" }
    association :user
  end
end
