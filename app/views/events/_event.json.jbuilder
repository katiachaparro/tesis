json.extract! event, :id, :name, :form_start, :event_start, :location, :event_nature, :threats, :affected_area, :isolation, :objectives, :strategy, :tactics, :pc_location, :e_location, :entry_route, :egress_route, :security_message, :communication_channels, :commander, :created_at, :updated_at
json.url event_url(event, format: :json)
