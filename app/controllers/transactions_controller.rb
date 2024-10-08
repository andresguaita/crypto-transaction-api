class TransactionsController < ApplicationController
  def create
    transaction = CreateTransactionService.new(current_user, transaction_params).call

    if transaction
      render json: transaction, status: :created
    else
      render json: { error: 'Insufficient balance or invalid parameters' }, status: :unprocessable_entity
    end
  end

  def index
    transactions = current_user.transactions
    render json: transactions
  end

  def show
    transaction = current_user.transactions.find(params[:id])
    render json: transaction
  end

  private

  def transaction_params
    params.permit(:currency_sent, :currency_received, :amount_sent)
  end
end
