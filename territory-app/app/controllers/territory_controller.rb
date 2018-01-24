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
      erb :'/territories/new'
    else redirect to "/login"
    end
  end

  post '/territories/new' do
    if logged_in?
    @territory = Territory.new(params)
      if @territory.save
        session[:territory_id] = @territory.id
        session[:number] = @territory.number
        session[:number] = @user.territories
        session[:designation] = @territory.designation
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
      erb :"/territories/show_territory"
    else
      redirect '/login'
    end
  end

  get '/territories/:id/edit' do
    if logged_in?
      @territory = Territory.find(params[:id])
    else
      redirect '/login'
    end
    binding.pry
      if @territory.save
        session[:territory_id] = @territory.id
        session[:number] = @territory.number
        session[:number] = @user.territories
        session[:designation] = @territory.designation
        redirect "/territories/#{@territory.id}"
      else
        redirect '/territories/territories'
      end
    erb :"territories/edit"
  end

  post '/territories/edit' do
    redirect "/territories/territories"
  end
end
