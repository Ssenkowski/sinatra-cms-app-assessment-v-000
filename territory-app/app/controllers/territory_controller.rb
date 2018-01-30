require 'pry'
class TerritoryController < ApplicationController

  get '/territories/territories' do
    if logged_in?
      @user = current_user
      @territories = Territory.all
      erb :"territories/territories"
    else
      redirect '/territories/unauthorized'
    end
  end

  get '/territories/new' do
    if logged_in?
      @user = current_user
      erb :'/territories/new'
    else
      redirect to '/territories/unauthorized'
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
      flash[:error] = "Empty fields or territory with that number already exists. Please fill out all the fields or try a different territory number."
      redirect '/territories/new'
    end
  end

  get '/territories/unauthorized' do
    erb :'/territories/unauthorized'
  end

  get "/territories/:id" do
    if logged_in?
      @territory = Territory.find(params[:id])
      @creator_id_string = @territory.user_id
      @creator_id = @creator_id_string.to_i
      @manager = User.find_by_id(@creator_id)
      erb :"/territories/show_territory"
    else
      redirect '/territories/unauthorized'
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
      redirect '/territories/unauthorized'
    end
  end

  post '/territories/:id' do
    if logged_in?
      @territory.user_id == session[:user_id]
    @territory = Territory.find(params[:id])
    if @territory.update(params)
      redirect "/territories/#{@territory.id}"
    else
      flash[:error] = "That territory number is already in use.  Please enter a different number."
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
