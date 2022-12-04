class Event < ApplicationRecord
  audited
  extend Enumerize
  has_many :event_actions
  has_many :victims
  accepts_nested_attributes_for :event_actions,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :victims,
                                reject_if: :all_blank, allow_destroy: true
  enumerize :kind, in: [:event, :incident], scope: :shallow

  validates :name, presence: true
end
