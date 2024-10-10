require 'faraday'
require 'json'

class FaradayHttpClient < HttpClient
  def self.get(url, headers: {}, params: {})
    begin
      response = Faraday.get(url, params, headers)
      puts response
      response
      parse_response(response)
    rescue Faraday::TimeoutError
      { error: 'Request timed out', status: 408 }
    rescue Faraday::ConnectionFailed => e
      { error: "Connection failed: #{e.message}", status: 503 }
    rescue JSON::ParserError => e
      { error: "Response parsing failed: #{e.message}", status: 500 }
    rescue StandardError => e
      { error: "An unexpected error occurred: #{e.message}", status: 500 }
    end
  end

  private

  def self.parse_response(response)
    if response.success?
      { data: JSON.parse(response.body), status: response.status }
    else
      { error: "Error: #{response.status} - #{response.body}", status: response.status }
    end
  end
end
