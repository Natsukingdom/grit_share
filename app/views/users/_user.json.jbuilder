json.extract! user, :id, :nickname, :mail, :password_digest, :birthday, :created_at, :updated_at
json.url user_url(user, format: :json)
