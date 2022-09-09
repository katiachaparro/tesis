class Event < ApplicationRecord
  extend Enumerize
  has_many :event_actions
  accepts_nested_attributes_for :event_actions,
                                reject_if: :all_blank, allow_destroy: true
  enumerize :kind, in: [:event, :incident], scope: :shallow
end
