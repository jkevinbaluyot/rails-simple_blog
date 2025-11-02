class Project < ApplicationRecord
  has_and_belongs_to_many :technologies
  scope :with_technologies, -> { includes(:technologies) }
end
