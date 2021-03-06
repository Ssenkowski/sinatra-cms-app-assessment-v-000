require 'pry'
class UserController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.new(params)
        if @user.save
          redirect '/users/show_user'
        else
          flash[:error] = "Please be sure to fill out all the fields, if you have and you still see this message the username may already be in use, try a different username."
          redirect '/signup'
      end
    end

    get '/login' do
      if logged_in?
        redirect '/users/show_user'
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
        redirect '/users/show_user'
      else
        flash[:error] = "Invalid log in."
        redirect '/login'
      end
    end

    get '/users/show_user' do
      if logged_in?
        @user = current_user
        erb :"/users/show_user"
      else
        flash[:error] = "You need to be logged in to view this page."
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
        redirect '/'
      else
        redirect '/'
      end
    end

end
