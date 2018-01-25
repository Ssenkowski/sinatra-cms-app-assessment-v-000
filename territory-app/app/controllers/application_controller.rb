require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "territory_secret"
    register Sinatra::Flash
  end

  get "/" do
    if !logged_in?
      flash[:notice] = "You are not logged in. Please log in to view more."
    else
      @current_user = "#{current_user.first_name} #{current_user.last_name}"
      flash[:notice] = "You are logged in as #{@current_user}"
    end
    erb :index
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
