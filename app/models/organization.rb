class Organization < ApplicationRecord
  belongs_to :parent_organization, foreign_key: :parent_organization_id, class_name: 'Organization', optional: true
  has_many :child_organizations, foreign_key: :parent_organization_id, class_name: 'Organization'
  has_many :resource_per_organizations

  #validations
  validates :name, presence: true, uniqueness: true

  #scopes
  scope :allow_sub_organizations, -> { where(allow_sub_organizations: true) }
end
