json.extract! user, :id, :username, :password_digest, :name, :role, :avatar, :created_at, :updated_at
json.url user_url(user, format: :json)
