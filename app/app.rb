ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    'Hello World'
  end

  get '/links' do
    @links = Link.all
    erb(:'links/index')
  end

  post '/links' do
    link = Link.new(url: params[:url],
                title: params[:title])
    tags = params[:tags].split(' ')
    tags.each do |tag|
      new_tag  = Tag.first_or_create(name: tag)
      link.tags << new_tag
    end
    link.save
    redirect '/links'
  end

  get '/links/new' do
    erb(:'links/new')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
  @links = tag ? tag.links : []
  erb :'links/index'
  end

  get '/users/new' do
    erb(:'users/new')
  end

  post '/users' do
    user = User.create(params)
    session[:user_id] = user.id
    redirect '/links'
  end
end
