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

    get '/login' do
      if logged_in?
        redirect '/territories'
      else
        erb :'users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.save
      if @user && @user.authenticate('password')
        session[:user_id] = @user.id
        redirect '/territories'
      else
        redirect '/login'
      end
    end

    get '/users'

    get '/logout' do
      session.clear
      redirect '/login'
    end

end
