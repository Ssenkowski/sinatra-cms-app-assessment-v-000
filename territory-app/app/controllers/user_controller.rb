require 'pry'
class UserController < ApplicationController

  get '/signup' do
      if logged_in?
        redirect '/territories'
      else
        erb :'users/signup'
      end
    end

    post '/signup' do
      if logged_in?
        redirect '/territories'
      end
        @user = User.new(params)
        #binding.pry
        if @user.save
        session[:user_id] = @user.id
        redirect '/territories'
      else
        redirect '/signup'
      end
    end
end
