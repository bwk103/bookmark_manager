class BookmarkManager < Sinatra::Base

  get '/' do
    redirect '/links'
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
end
