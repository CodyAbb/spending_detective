require('sinatra')
require( 'sinatra/contrib/all' )
require_relative( '../models/tag.rb' )
also_reload( '../models/*' )

class TagsController < Sinatra::Base
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
    redirect to '/tags'
  end

  # edit
  get '/tags/:id/edit' do
    @tag = Tag.find(params[:id])
    erb(:"tags/edit")
  end

  # update
  post '/tags/:id' do
    tag = Tag.new(params)
    tag.update()
    redirect to '/tags'
  end
end
