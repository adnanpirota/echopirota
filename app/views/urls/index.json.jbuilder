json.array!(@urls) do |url|
  json.extract! url, :id, :url, :description
  json.url url_url(url, format: :json)
end
