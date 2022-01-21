class Transaction < ApplicationRecord
  belongs_to :property
  belongs_to :user

  enum status: {pending: 0, confirmed: 1}, _suffix: true
end
