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
  accepts_nested_attributes_for :resource_requests,
                                reject_if: :all_blank, allow_destroy: true
  enumerize :kind, in: [:event, :incident], scope: :shallow

  validates :name, presence: true

  def version_by_attribute(attr)
    changes = audits.select { |v| v.audited_changes[attr].present? && v.audited_changes[attr][1].present? }
    return self[attr] unless changes.many?

    first = changes.shift
    changes.reduce(get_version_value(first, attr)) { |result, v| "#{result} <font size='9'><i>(#{v.created_at&.strftime('%d-%m-%Y %H:%M')})</i></font><br>#{ get_version_value(v, attr) }" }
  end

  private
  def get_version_value(v, attr)
    v.audited_changes[attr].is_a?(String) ? v.audited_changes[attr] : v.audited_changes[attr][1]
  end
end
