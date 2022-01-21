class User < ApplicationRecord
  devise :database_authenticatable

  has_one :account
  has_many :transactions
end
