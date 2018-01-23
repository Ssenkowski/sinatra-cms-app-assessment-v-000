require 'pry'
class UserController < ApplicationController

  get '/signup' do
      if logged_in?
        redirect '/show_user'
      else
        erb :'users/signup'
      end
    end

    post '/signup' do
      if logged_in?
        redirect '/show_user'
      end
        @user = User.new(params)
        if @user.save
          session[:user_id] = @user.id
          session[:first_name, :last_name] = @user.name
          session[:email] = @user.email
          session[:username] = @user.username
          redirect '/show_user'
        else
          redirect '/signup'
      end
    end

    get '/login' do
      if logged_in?
        redirect '/show_user'
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
        redirect '/show_user'
      else
        redirect '/login'
      end
    end

    get '/profile/:id' do

      erb :"/profile"
    end

    get '/logout' do
      session.clear
      redirect '/login'
    end

end
