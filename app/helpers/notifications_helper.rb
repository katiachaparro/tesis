module NotificationsHelper
  include AssistRequestsHelper

  def notify_new_resource_request(event, resource_request)
    if resource_request.organization.present?
      message = "Te han solicitado nuevos recursos en #{resource_request.code} (Solicitud Directa)"
      users = User.exclude_organization(resource_request.organization.users)
    else
      message = "Se han solicitado nuevos recursos en #{resource_request.code}."
      users = User.exclude_organization(event.organization_id)
    end
    EventNotification.with(event: event, message: message).deliver(users)
  end

  def notify_assist_request(resource_request, user)
    org = Organization.find_by_id user.organization_id
    message = "La organización #{org.name} ha asistido a la solicitud #{resource_request.code}."
    users = resource_request.event&.organization&.users
    EventNotification.with(event: resource_request.event, message: message).deliver(users)
  end

  def notify_resource_state_change(assist_request)
    message = "El recurso #{assist_request.code} ha cambiado su estado a \"#{show_assist_status(assist_request)}\"."
    users = assist_request.organization.users
    EventNotification.with(event: assist_request.event, message: message).deliver(users)
  end

  def notify_resource_arrived(assist_request)
    message = "El recurso #{assist_request.code} ha arribado a la escena."
    users = assist_request.organization.users
    EventNotification.with(event: assist_request.event, message: message).deliver(users)
  end

  def notify_resource_demobilize(assist_request)
    message = "El recurso #{assist_request.code} se ha desmovilizado."
    users = assist_request.organization.users
    EventNotification.with(event: assist_request.event, message: message).deliver(users)
  end

  def notify_close_event(event)
    message = "El #{event.kind.text} ha sido cerrado y todos los recursos desmovilizados"
    org_ids = event.assist_requests.pluck(:organization_id).push(event.organization_id)
    users = User.include_organization(org_ids)
    EventNotification.with(event: event, message: message).deliver(users)
  end
end