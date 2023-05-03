class Organization < ApplicationRecord
  belongs_to :parent_organization, foreign_key: :parent_organization_id, class_name: 'Organization', optional: true
  has_many :child_organizations, foreign_key: :parent_organization_id, class_name: 'Organization'
  has_many :resource_per_organizations

  #validations
  validates :name, presence: true, uniqueness: true

  #scopes
  scope :allow_sub_organizations, -> { where(allow_sub_organizations: true) }
  # @return [Integer]
  before_save :is_main_organizer

  @private
  def is_main_organizer
    if !self.parent_organization_id?
      self.parent_organization_id = Organization.first.id
      self.allow_sub_organizations = true
    else

    end
  end
end
