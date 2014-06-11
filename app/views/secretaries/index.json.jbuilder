json.array!(@secretaries) do |secretary|
  json.extract! secretary, :id, :nusp, :name, :email, :password
  json.url secretary_url(secretary, format: :json)
end
