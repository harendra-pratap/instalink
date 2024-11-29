# Geocoder.configure(
#   lookup: :google,
#   api_key: ENV['GOOGLE_MAPS_API_KEY'],
#   use_https: true,
#   timeout: 5,
#   units: :km
# )


Geocoder.configure(
  ip_lookup: :ipstack,
  api_key: ENV['IPSTACK_API_KEY'],
  timeout: 5,
  use_https: true
)