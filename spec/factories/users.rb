FactoryBot.define do
  factory :user do
    email { "one@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
