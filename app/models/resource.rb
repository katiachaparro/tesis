class Resource < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, :kind, presence: true
  has_many :resource_per_organizations

  #scopes
  scope :active_resources, -> { where(active: true) }
end
