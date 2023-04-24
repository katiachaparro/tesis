class Victim < ApplicationRecord
  extend Enumerize
  belongs_to :event

  enumerize :sex, in: [:male, :female], scope: :shallow
  enumerize :classification, in: [:red, :yellow, :green, :black], scope: :shallow
end
