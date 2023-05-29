module AssistRequestsHelper
  def show_assist_status(assisted_item)
    return unless assisted_item.arrived

    assigned_text = assisted_item.assigned_to? ? ": #{assisted_item.assigned_to}" : ''
    "#{assisted_item.status.text} #{assigned_text}"
  end
end
