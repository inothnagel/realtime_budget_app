module TransactionsHelper

  def render_transactions_table(transactions_owner)
    @transactions = transactions_owner.transactions.order(:datetime_executed).reverse_order
    render "transactions/transactions_table_small"
  end
end
