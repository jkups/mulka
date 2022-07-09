class Seller < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable
  # :registerable, :recoverable, :rememberable, :validatable

  belongs_to :organization, class_name: Organizations::Organization.name
  has_many :properties, class_name: Properties::Property.name
end
