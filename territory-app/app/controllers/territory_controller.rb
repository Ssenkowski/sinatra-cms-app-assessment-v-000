require 'pry'
class TerritoryController < ApplicationController

  get '/territories/territories' do
    if logged_in?
      @user = current_user
      @territories = Territory.all
      # binding.pry
      erb :"territories/territories"
    else
      redirect '/login'
    end
  end

  get '/territories/new' do
    if logged_in?
      @user = current_user
      erb :'/territories/new'
    else
      redirect to "/login"
    end
  end

  post '/territories/new' do
    @territory_params = Territory.new(params)
    @territory = @territory_params
    @territory[:id] = "#{session[:territory_id]}"
    @territory[:user_id] = "#{session[:user_id]}"
      if @territory.save
        redirect "/territories/#{@territory.id}"
      else
        redirect '/territories/new'
      end
  end

  get '/territories/unauthorized' do

    erb :'/territories/unauthorized'
  end

  get "/territories/:id" do
    if logged_in?
      @territory = Territory.find(params[:id])
      @user = User.find_by(params[:user_id])
      erb :"/territories/show_territory"
    else
      redirect '/login'
    end
  end

  get '/territories/:id/edit' do
    if logged_in?
      @territory = Territory.find(params[:id])
      @user_id = session[:user_id]
      @user = User.find_by(params[:"#{@user_id}"])
      if @territory.user_id == session[:user_id]
        erb :"territories/edit"
      else
        redirect to '/territories/unauthorized'
      end
    else
      redirect '/login'
    end
  end

  post '/territories/:id' do
    @territory = Territory.find(params[:id])
    if @territory.update(params)
      redirect "/territories/#{@territory.id}"
    else
      redirect "/territories/#{@territory.id}/edit"
    end
  end

  patch '/territories/:id/delete' do
    @territory = Territory.find(params[:id])
    if @territory.user_id == session[:user_id]
      @territory.delete
      redirect '/territories/territories'
    else
      redirect to '/territories/unauthorized'
    end
  end
end
