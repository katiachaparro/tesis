class AssistRequest < ApplicationRecord
  extend Enumerize
  belongs_to :resource_request_item
  belongs_to :organization
  delegate :resource, :to => :resource_request_item, :allow_nil => true

  enumerize :status, in: [:available, :not_available, :assigned_to], scope: :shallow

  def self.create_assist_items(request_item_id, quantity, current_user)
    ActiveRecord::Base.transaction do
      request_item = ResourceRequestItem.find_by_id(request_item_id)
      org_id = current_user.organization_ids.first
      resource = request_item&.resource

      # return if resource doesn't exits
      return if org_id.nil? || resource.nil?

      (1..quantity).each { |i|
        AssistRequest.create(resource_request_item: request_item, organization_id: org_id, status: AssistRequest.status.available, code: "#{resource.name[0..2].upcase}#{i}")
      }

      request_item.increment!(:quantity_used, by = quantity)
      ResourcePerOrganization.find_by(resource: resource, organization_id: org_id)&.increment!(:quantity_used, by = quantity)
    end
  end
end
