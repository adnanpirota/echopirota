json.array!(@radios) do |radio|
  json.extract! radio, :id, :name, :uri
  json.url radio_url(radio, format: :json)
end
