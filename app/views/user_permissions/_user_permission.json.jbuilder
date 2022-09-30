json.extract! user_permission, :id, :organization_id, :user_id, :created_at, :updated_at
json.url user_permission_url(user_permission, format: :json)
