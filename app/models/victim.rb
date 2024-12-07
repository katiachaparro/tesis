class Victim < ApplicationRecord
  extend Enumerize
  belongs_to :event

  validates :name, :sex, :classification, :place_of_registration, :age, :date, presence: true

  enumerize :sex, in: [:male, :female], scope: :shallow
  enumerize :classification, in: [:red, :yellow, :green, :black], scope: :shallow
  enumerize :place_of_registration, in: [:acv, :medical_unit, :other], scope: :shallow

  def self.ransackable_attributes(auth_object = nil)
    %w[age classification created_at date event_id name place_of_registration place_of_transfer sex transferred_by treated_on_site]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[event]
  end
end
