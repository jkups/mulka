class Organizations::Organization < ApplicationRecord
  has_many :properties, class_name: Properties::Property.name, foreign_key: "organization_id"
end
