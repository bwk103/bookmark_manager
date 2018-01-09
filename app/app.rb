ENV['RACK_ENV'] = 'development'
require 'sinatra/base'
require './app/models/link'

class BookmarkManager < Sinatra::Base

  get '/' do
    'Hello World'
  end

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  post '/links' do
    Link.create(params)
    redirect '/links'
  end

  get '/links/new' do
    erb(:'links/new')
  end
end
