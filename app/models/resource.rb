class Resource < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, :kind, presence: true
end
