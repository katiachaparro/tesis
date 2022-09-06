class Resource < ApplicationRecord
  extend Enumerize
  validates :name, uniqueness: true
  validates :name, :kind, presence: true
  has_many :resource_per_organizations

  enumerize :kind, in: [:logistics, :human_talent, :physical], scope: :shallow
  #scopes
  scope :active_resources, -> { where(active: true) }
  scope :resource_with_total, -> { select("resources.*, sum(resource_per_organizations.quantity) AS total").left_outer_joins(:resource_per_organizations).group("resources.id") }

end
