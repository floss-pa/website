json.extract! ticket, :id, :event_id, :amount, :ticket_type_id, :token, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
