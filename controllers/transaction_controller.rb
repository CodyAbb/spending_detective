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

  get ('/transactions/dates/?') do
    @transactions = Transaction.all
    @month_transactions = Transaction.current_month_transactions
    erb(:"transactions/show_date")
  end

  post ('/transactions/dates/?') do
    @transactions = Transaction.all
    month_index = params[:month_index]
    year = params[:year]
    @month_transactions = Transaction.select_month_transactions(month_index, year)
    erb(:"transactions/show_date")
  end

  get ('/transactions/merchants/?') do
    @transactions = Transaction.all
    @merchants = Merchant.all
    initial_merchant = Merchant.all.first.id
    @merchant_transactions = Transaction.merchant_transactions(initial_merchant)
    erb(:"transactions/show_merchant")
  end

  post ('/transactions/merchants/?') do
    @transactions = Transaction.all
    @merchants = Merchant.all
    merchant_term = params[:merchant_term]
    @merchant_transactions = Transaction.merchant_transactions(merchant_term)
    erb(:"transactions/show_merchant")
  end

  get ('/transactions/tags/?') do
    @transactions = Transaction.all
    @tags = Tag.all
    initial_tag = Tag.all.first.id
    @tag_transactions = Transaction.tag_transactions(initial_tag)
    erb(:"transactions/show_tag")
  end

  post ('/transactions/tags/?') do
    @transactions = Transaction.all
    @tags = Tag.all
    tag_term = params[:tag_term]
    @tag_transactions = Transaction.tag_transactions(tag_term)
    erb(:"transactions/show_tag")
  end

  post ('/transactions/:id/delete') do
    Transaction.delete(params[:id])
    redirect to ("/transactions")
  end
