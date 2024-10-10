class BitcoinPriceController < ApplicationController
    def show
      btc_price_usd = BitcoinPriceService.get_usd_price
  
      if btc_price_usd
        render json: { btc_price_in_usd: btc_price_usd }, status: :ok
      else
        render json: { error: btc_price_usd[:error] }, status: :service_unavailable
      end
    end
end
  