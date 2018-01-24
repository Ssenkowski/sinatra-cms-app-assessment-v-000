require 'pry'
class UserController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.new(params)
        binding.pry
        if @user.save
          redirect '/users/show_user'
        else
          redirect '/signup'
      end
    end

    get '/login' do
      if logged_in?
        redirect '/'
      else
        erb :'/users/login'
      end
    end

    post '/login' do
      @user = User.find_by(username: params[:username])
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.save
      if @user && @user.authenticate('password')
        session[:user_id] = @user.id
        redirect '/'
      else
        redirect '/login'
      end
    end

    get '/users/show_user' do
      if logged_in?
        @user = current_user
        binding.pry

        erb :"/users/show_user"
      else
        redirect '/login'
      end
    end

    patch '/users/:id/delete' do
      @user = current_user
      # if @territory.user_id == session[:user_id]
        @user.delete
      redirect '/logout'
      # end
    end

    get '/logout' do
      if logged_in?
        session.clear
        redirect '/login'
      else
        redirect '/login'
      end
    end

end
