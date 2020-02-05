require('sinatra')
# require( 'sinatra/contrib/all' )
require('sinatra/base')
require_relative('./controllers/tag_controller')
require_relative('./controllers/merchant_controller')
require_relative('./controllers/transaction_controller')

class App < Sinatra::Base
  use MerchantsController
  use TagsController
  use TransactionsController
  get ('/?') do
    erb(:'/index')
  end
end
