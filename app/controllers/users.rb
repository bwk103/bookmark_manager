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

  get '/users/recover' do
    erb(:'users/recover')
  end

  post '/users/recover' do
    @user = User.first(email: params[:email])
    if @user
      @user.generate_token
    end
    erb(:'/users/acknowledgement')
  end

  get '/users/reset_password' do
    @user = User.find_by_valid_token(params[:token])
    if @user
      session[:token] = params[:token]
      erb(:'users/reset_password')
    else
      'Your token is invalid'
    end
  end

  patch '/users' do
    @user = User.find_by_valid_token(session[:token])
    if @user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
      session[:token] = nil
      @user.update(password_token: nil)
      redirect '/sessions/new'
    else
      flash.keep[:error] = @user.errors.full_messages
      redirect "/users/reset_password?token=#{session[:token]}"
    end
  end
end
