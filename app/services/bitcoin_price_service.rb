class BitcoinPriceService

    COINDESK_URL = ENV.fetch('COINDESK_API_URL')

    def self.get_usd_price
      response = HttpClient.get(COINDESK_URL)
      if response[:status] == 200
        btc_price = response[:data]["bpi"]["USD"]["rate_float"]
        btc_price
      else
        { error: 'Unable to fetch BTC price' }
      end
    end
end
  