class TransactionService
  attr_reader :errors, :transaction

  def initialize(user, params)
    @user = user
    @send_currency = params[:currency_sent]
    @receive_currency = params[:currency_received]
    @amount_sent = params[:amount_sent].to_f
    @errors = []
    @transaction = nil
  end

  def process_transaction

    ActiveRecord::Base.transaction do
      sender_wallet = @user.wallets.find_by(currency: @send_currency)
      receiver_wallet = @user.wallets.find_by(currency: @receive_currency)

      unless sender_wallet && receiver_wallet
        @errors << 'One of the wallets does not exist'
        false  
      end

      if sender_wallet.balance < @amount_sent
        @errors << 'Insufficient balance'
        puts sender_wallet.balance
        false  
      end

      btc_price = BitcoinPriceService.get_usd_price

      unless btc_price
        @errors << 'Could not retrieve Bitcoin price'
        false 
      end

      amount_received = calculate_amount_received(btc_price)

      if amount_received.nil?
        @errors << 'Invalid transaction, amount received is null'
        false
      end
   
      sender_wallet.update!(balance: sender_wallet.balance - @amount_sent)
      receiver_wallet.update!(balance: receiver_wallet.balance + amount_received)

      @transaction = Transaction.create!(
        user: @user,
        currency_sent: @send_currency,
        currency_received: @receive_currency,
        amount_sent: @amount_sent,
        amount_received: amount_received
      )
    end
    true 
  rescue => e
    @errors << e.message
    false
  end

  private

  def calculate_amount_received(btc_price)
    if @receive_currency == 'BTC'
      (@amount_sent / btc_price).round(8)
    elsif @receive_currency == 'USD'
      (@amount_sent * btc_price).round(2)
    else
      nil
    end
  end
end
