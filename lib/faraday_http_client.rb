require 'faraday'
require 'json'

class FaradayHttpClient < HttpClient
  def self.get(url, headers: {}, params: {})
    response = Faraday.get(url, params, headers)
    parse_response(response)
  end

  private

  def self.parse_response(response)
    if response.success?
      JSON.parse(response.body)
    else
      raise "Error: #{response.status} - #{response.body}"
    end
  end
end
