class EventAction < ApplicationRecord
  belongs_to :event
  validates :date, :description, presence: true
end
