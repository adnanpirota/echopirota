json.array!(@matches) do |match|
  json.extract! match, :id, :fingerprint_id, :url_id
  json.url match_url(match, format: :json)
end
