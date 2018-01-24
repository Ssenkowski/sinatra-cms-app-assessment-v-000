require 'pry'
class TerritoryController < ApplicationController

  get '/territories/territories' do
    @territories = Territory.all
    # binding.pry
    erb :"territories/territories"
  end

  get '/territories/new' do
    erb :'/territories/new'
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
      redirect '/users/login'
    end
  end

  get "/territories/:id" do
    @territory = Territory.find(params[:id])
    erb :"/territories/show_territory"
  end

  get '/territories/:id/edit' do
    erb :"territories/edit"
  end

  patch '/territories/:id/edit' do
    redirect "/territories/show_territory"
  end

  get '/territories/sign_out' do

    erb :"/territories/sign_out"
  end

  post '/territories/sign_out' do

    redirect :"/users/show_user"
  end

end
