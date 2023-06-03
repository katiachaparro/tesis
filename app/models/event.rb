class Event < ApplicationRecord
  audited
  extend Enumerize
  has_many_attached :sketchs do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_many_attached :organization_charts do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_many :event_actions
  has_many :victims
  has_many :resource_requests
  accepts_nested_attributes_for :event_actions,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :victims,
                                reject_if: :all_blank, allow_destroy: true
  enumerize :kind, in: [:event, :incident], scope: :shallow

  validates :name, presence: true

  attr_accessor :demobilization_date, :demobilizing_person, :comments
end
