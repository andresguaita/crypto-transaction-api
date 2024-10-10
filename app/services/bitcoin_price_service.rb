class BitcoinPriceService

   # COINDESK_URL = ENV.fetch('COINDESK_API_URL')

    def self.get_usd_price
      response = HttpClient.get('https://api.coindesk.com/v1/bpi/currentprice.json')
      puts response[:status]
      if response[:status] == 200
        btc_price = response.parsed_response['bpi']['USD']['rate_float']
      else
        { error: 'Unable to fetch BTC price' }
      end
    end
end
  