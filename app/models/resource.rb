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
  scope :ts_select, -> { active_resources.map { |r| { name: r.name, id: r.id } }}
end
