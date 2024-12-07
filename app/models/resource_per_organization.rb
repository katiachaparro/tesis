class ResourcePerOrganization < ApplicationRecord
  belongs_to :resource
  belongs_to :organization

  #validations
  validates :organization, :resource, presence: true
  validates :resource, uniqueness: { scope: :organization }
  validates :quantity, numericality: { greater_than: 0 }

  #scopes
  scope :by_organization, -> (organization){ where(organization_id: organization&.id) }
  scope :quantity_gt_quantity_used, -> (val=nil){ where('quantity > quantity_used') } # for ransack filter

  def self.ransackable_attributes(auth_object = nil)
    %w[resource]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[organization resource]
  end

  def self.ransackable_scopes(auth_object = nil)
    %i(quantity_gt_quantity_used)
  end
end
