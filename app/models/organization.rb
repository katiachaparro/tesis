class Organization < ApplicationRecord
  belongs_to :parent_organization, foreign_key: :parent_organization_id, class_name: 'Organization', optional: true
  has_many :child_organizations, foreign_key: :parent_organization_id, class_name: 'Organization'
  has_many :resource_per_organizations
  has_many :user_permissions
  has_many :users, through: :user_permissions

  #validations
  validates :name, presence: true, uniqueness: true

  #scopes
  scope :allow_sub_organizations, -> { where(allow_sub_organizations: true) }
  scope :organization_and_children, -> (org_id) { where(id: org_id).or(where(parent_organization_id: org_id)).order(:name) }

  # @return [Integer]
  before_save :is_main_organizer

  ActionController::Parameters.permit_all_parameters = true

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  @private
  def is_main_organizer
    unless self.parent_organization_id?
      self.parent_organization_id = Organization.first&.id
      self.allow_sub_organizations = true
    end
  end
end
