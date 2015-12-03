json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :picture_url, :password_digest
  json.url user_url(user, format: :json)
end
