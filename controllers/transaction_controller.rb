require('sinatra')
require( 'sinatra/contrib/all' )
require_relative( '../models/tag.rb' )
require_relative('../models/merchant.rb')
require_relative('../models/transaction.rb')
also_reload( '../models/*' )

get ('/transactions/?') do
  @transactions = Transaction.all()
  @total_transaction_value = Transaction.total_transactions()
  merchant_array = Merchant.all()
  @merchants = Merchant.update_active(merchant_array)
  erb(:'transactions/index')
end

get ('/transactions/new') do
  @tags = Tag.all
  merchant_array = Merchant.all
  @merchants = Merchant.availability_check(merchant_array)
  erb(:'transactions/new')
end

post ('/transactions') do
  transaction = Transaction.new(params)
  transaction.save
  redirect to ('/transactions')
end

# edit
get ('/transactions/:id/edit') do
  @transaction = Transaction.find(params['id'].to_i)
  @tags = Tag.all
  merchant_array = Merchant.all
  @merchants = Merchant.availability_check(merchant_array)
  erb(:"transactions/edit")
end

# update
post ('/transactions/:id') do
  transaction = Transaction.new(params)
  transaction.update()
  redirect to '/transactions'
end

get ('/transactions/dates') do
  @transactions = Transaction.all()
  @month_transactions = Transaction.current_month_transactions
  erb(:"transactions/show_date")
end

post ('/transactions/:id/delete') do
  Transaction.delete(params[:id])
  redirect to ("/transactions")
end
