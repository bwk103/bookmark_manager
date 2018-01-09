ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  get '/' do
    'Hello World'
  end

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  post '/links' do
    link = { title: params['title'], url: params['url'] }
    tag = { name: params['tags']}
    Link.create(link)
    Tag.create(tag)
    LinkTag.create(:link => link, :tag => tag)
    redirect '/links'
  end

  get '/links/new' do
    erb(:'links/new')
  end
end
