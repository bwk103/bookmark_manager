class BookmarkManager < Sinatra::Base

  get '/users/new' do
    @user = User.new
    erb(:'users/new')
  end

  post '/users' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash[:error] = @user.errors.full_messages
      redirect '/users/new'
    end
  end
end
