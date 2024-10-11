class TransactionsController < ApplicationController
  before_action :authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    create_transaction = TransactionService.new(current_user, transaction_params)
    if create_transaction.process_transaction
      render json: create_transaction.transaction, status: :created
    else
      render json: { error: create_transaction.errors }, status: :unprocessable_entity
    end
  end

  def index

   user = User.find_by(id: params[:user_id])
   if user.nil?
     return render json: { error: "User not found" }, status: :not_found
   end

   transactions = user.transactions
   if transactions.empty?
     return render json: { message: "No transactions found for this user", transactions: [] }, status: :ok
   end
 
   render json: transactions, status: :ok   
  end

  def show
    transaction = current_user.transactions.find(params[:id])
    render json: transaction
  end

  private

  def transaction_params
    params.permit(:currency_sent, :currency_received, :amount_sent)
  end

  def record_not_found
    render json: { error: "Transaction not found" }, status: :not_found
  end
end
