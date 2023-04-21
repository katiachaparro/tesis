class Resource < ApplicationRecord
  extend Enumerize
  has_many :resource_per_organizations
  enumerize :kind, in: [:logistics, :human_talent, :physical], scope: :shallow

  #validations
  validates :name, uniqueness: true
  validates :name, :kind, presence: true

  #scopes
  scope :active_resources, -> { where(active: true) }
  scope :resource_with_total, -> { select("resources.*, sum(resource_per_organizations.quantity) AS total").left_outer_joins(:resource_per_organizations).group("resources.id") }

  def self.ransackable_attributes(auth_object = nil)
    ["active", "created_at", "description", "id", "kind", "name", "updated_at"]
  end
end
