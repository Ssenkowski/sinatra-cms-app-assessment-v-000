require 'pry'
class TerritoryController < ApplicationController

  get '/territories/territories' do
    if logged_in?
      @territories = Territory.all
      # binding.pry
      erb :"territories/territories"
    else
      redirect '/login'
    end
  end

  get '/territories/new' do
    if logged_in?
      @user = User.find_by(params[:first_name])
      erb :'/territories/new'
    else redirect to "/login"
    end
  end

  post '/territories/new' do
    if logged_in?
    @territory = Territory.new(params)
    @user = User.find_by(params[:user_id])
      if @territory.save
        session[:territory_id] = @territory.id
        session[:number] = @territory.number
        session[:user_id] = @user.id
        session[:designation] = @territory.designation
        binding.pry
        redirect "/territories/#{@territory.id}"
      else
        redirect '/territories/new'
      end
      redirect '/login'
    end
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
      @user = User.find(params[:id])
      erb :"territories/edit"
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
    # if @territory.user_id == session[:user_id]
      @territory.delete
    redirect '/territories/territories'
    # end
  end
end
