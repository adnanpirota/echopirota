json.array!(@fingerprints) do |fingerprint|
  json.extract! fingerprint, :id, :fingerprint
  json.url fingerprint_url(fingerprint, format: :json)
end
