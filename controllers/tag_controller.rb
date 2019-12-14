require('sinatra')
require( 'sinatra/contrib/all' )
require_relative( '../models/tag.rb' )
also_reload( '../models/*' )

get ('/tags/?') do
  @tags = Tag.all()
  erb('../views/tags/index.erb')
end

get ('/tags/:id') do
  @tag = Tag.find(params['id'].to_i)
  erb('../views/tags/show.erb')
end
