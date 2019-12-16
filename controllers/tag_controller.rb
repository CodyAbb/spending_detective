require('sinatra')
require( 'sinatra/contrib/all' )
require_relative( '../models/tag.rb' )
also_reload( '../models/*' )

get ('/tags/?') do
  @tags = Tag.all()
  erb(:"tags/index")
end

get ('/tags/:id') do
  @tag = Tag.find(params['id'].to_i)
  erb(:"tags/show")
end

# create
post ('/tags') do
  @tag = Tag.new(params)
  @tag.save
  erb(:create)
end

# edit
get '/tags/:id/edit' do
  @houses = House.all()
  @tag = Tag.find(params[:id])
  erb(:edit)
end

# update
post '/tags/:id' do
  student = Tag.new(params).update()
  redirect to '/tags'
end

# destroy
post '/tags/:id/delete' do
  tag = Tag.find(params[:id])
  tag.delete()
  redirect to '/Tags'
end
