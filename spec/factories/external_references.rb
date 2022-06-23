FactoryBot.define do
  factory :external_reference do
    referenceable_source { "MyString" }
    referenceable_id { "MyString" }
  end
end
