class AssistRequest < ApplicationRecord
  audited
  include AssistRequestsHelper
  extend Enumerize
  belongs_to :resource_request_item
  belongs_to :organization
  belongs_to :event
  delegate :resource, :to => :resource_request_item, :allow_nil => true
  delegate :resource_request, :to => :resource_request_item, :allow_nil => true

  enumerize :status, in: [:available, :not_available, :assigned_to], scope: :shallow

  scope :resources_to_demobilize, -> (event_id) { where(event_id: event_id, arrived: true, demobilized: [nil, false]) }

  def assigned_to?
    status == AssistRequest.status.assigned_to
  end

  def self.create_assist_items(request_item_id, quantity, current_user)
    ActiveRecord::Base.transaction do
      request_item = ResourceRequestItem.find_by_id(request_item_id)
      org_id = current_user.organization_id
      resource = request_item&.resource

      # return if resource doesn't exits
      return if org_id.nil? || resource.nil?

      code_count = AssistRequest.where(event: request_item.event).count - 1
      (1..quantity).each { |i|
        AssistRequest.create(resource_request_item: request_item, event: request_item.event, organization_id: org_id, code: "#{resource.name[0..2].upcase}#{code_count + i}")
      }

      request_item.increment!(:quantity_used, by = quantity)
    end
  end

  def register_arrive(params)
    ActiveRecord::Base.transaction do
      params['arrived'] = true
      params['assigned_to'] = '' if params['status'] != AssistRequest.status.assigned_to
      update(params)
      EventAction.create(
        description: "El recurso #{code} ha registrado su arribo a la escena.",
        date: arrival_date,
        event: resource_request&.event
      )
      ResourcePerOrganization.find_by(resource: resource, organization: organization)&.increment!(:quantity_used)
    end
  end

  def change_state(params)
    ActiveRecord::Base.transaction do
      self.status = params['status']
      self.assigned_to = params['status'] == AssistRequest.status.assigned_to ? params['assigned_to'] : ''
      status_text = show_assist_status(self)
      self.comments = "#{status_text} #{params['comments']}" # Use updated attributes
      save!
      
      obs = params['comments'].present? ? " Obs: #{params['comments']}" : ''
      EventAction.create(
        description: "El recurso #{code} ha cambiado de estado a \"#{status_text}\".#{obs}",
        date: Time.zone.now,
        event: resource_request&.event
      )
    end
  end

  def demobilize(params, create_action = true)
    ActiveRecord::Base.transaction do
      params['demobilized'] = true
      params['comments'] = "Desmovilizado por #{params['demobilizing_person']} #{params['comments']}"
      update(params)
      ResourcePerOrganization.find_by(resource: resource, organization: organization)&.decrement!(:quantity_used)
      EventAction.create(
        description: "El recurso #{code} fue desmovilizado por #{demobilizing_person}.",
        date: demobilization_date,
        event: resource_request&.event
      ) if create_action
    end
  end
end
