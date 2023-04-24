class Victim < ApplicationRecord
  extend Enumerize
  belongs_to :event

  validates :name, presence: true

  enumerize :sex, in: [:male, :female], scope: :shallow
  enumerize :classification, in: [:red, :yellow, :green, :black], scope: :shallow
  enumerize :place_of_registration, in: [:acv, :medical_unit, :other], scope: :shallow
end
