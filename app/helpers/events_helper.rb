module EventsHelper
  def resource_request_status_class(rq)
    case rq.status
    when ResourceRequest.status.active
      'border border-success text-success'
    when ResourceRequest.status.canceled
      'border border-danger text-danger'
    when ResourceRequest.status.demobilized
      'border border-primary text-primary'
    else
      'border border-secondary text-secondary'
    end
  end
end
