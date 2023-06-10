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
  has_many :assist_requests
  accepts_nested_attributes_for :event_actions,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :victims,
                                reject_if: :all_blank, allow_destroy: true
  enumerize :kind, in: [:event, :incident], scope: :shallow

  validates :name, presence: true

  scope :active_events, -> { where(closed: [nil, false]) }
  scope :mappable_events, -> { active_events.where.not(longitude: nil) }
  scope :scheduled_events, -> (org_id) { active_events.where(kind: Event.kind.event, initialized: [nil, false]).or(where(assist_requests: {organization_id: org_id})) }

  attr_accessor :demobilization_date, :demobilizing_person, :comments

  def incident?
    kind == Event.kind.incident
  end

  def close_and_demobilize(params)
    ActiveRecord::Base.transaction do
      # cancel requests
      ResourceRequest.requests_to_demobilize(id).update_all(status: ResourceRequest.status.demobilized)

      # demobilize all resources
      resources_to_demobilize = AssistRequest.resources_to_demobilize(id)
      resources_to_demobilize.each{ |assist| assist.demobilize(params, false)}

      # create event action
      description = "El incidente fue CERRADO por #{params['demobilizing_person']}."
      description += " Fueron desmovilizados automáticamente los recursos: #{resources_to_demobilize.pluck(:code).join(', ')}" if resources_to_demobilize.any?
      EventAction.create(
        description: description,
        date: params['demobilization_date'],
        event: self
      )
      update(closed: true, event_end: params['demobilization_date'])
    end
  end
end
