json.array!(@advises) do |advise|
  json.extract! advise, :id, :title, :message
  json.url advise_url(advise, format: :json)
end
