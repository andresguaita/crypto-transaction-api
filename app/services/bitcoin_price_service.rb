class BitcoinPriceService

    COINDESK_URL = ENV.fetch('COINDESK_API_URL')
  
    def self.get_usd_price
      response = HttpClient.get(COINDESK_URL)
      usd_price= response['bpi']['USD']['rate_float']
      puts usd_price
      usd_price
    end
end
  