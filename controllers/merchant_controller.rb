require('sinatra')
require( 'sinatra/contrib/all' )
require_relative( '../models/merchant.rb' )
also_reload( '../models/*' )

get ('/merchants/?') do
  merchant_array = Merchant.all()
  @merchants = Merchant.update_active(merchant_array)
  erb(:'merchants/index')
end

get ('/merchants/:id') do
  @merchant = Merchant.find(params['id'].to_i)
end

# create
post ('/merchants') do
  @merchant = Merchant.new(params)
  @merchant.save
  redirect to '/merchants'
end

# edit
get '/merchants/:id/edit' do
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/edit")
end

# update
post '/merchants/:id' do
  merchant = Merchant.new(params)
  merchant.update()
  redirect to '/merchants'
end
