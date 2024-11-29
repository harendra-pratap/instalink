# class GoogleMapsService
#   include HTTParty
#   base_uri 'https://maps.googleapis.com/maps/api/geocode/json'

#   def self.get_location(lat, long)
#     response = get("", query: { latlng: "#{lat},#{long}", key: ENV['GOOGLE_MAPS_API_KEY'] })
#     if response.success? && response.parsed_response['results'].any?
#       response.parsed_response['results'].first['formatted_address']
#     else
#       nil
#     end
#   end
# end


class GoogleMapsService
  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api/geocode/json'

  def self.get_location(lat, long)
    response = get("", query: { latlng: "#{lat},#{long}", key: ENV['GOOGLE_MAPS_API_KEY'] })
    
    # Log the API response for debugging
    Rails.logger.debug "Google Maps Response: #{response.body}"

    if response.success? && response.parsed_response['results'].any?
      response.parsed_response['results'].first['formatted_address']
    else
      nil
    end
  end
end
