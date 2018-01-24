require 'pry'
class TerritoryController < ApplicationController

  get '/territories/territories' do
    @territories = Territory.all
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

  patch '/territories/:id/edit' do

    redirect "/territories/#{@territory.id}"
  end

  get '/territories/sign_in_or_out' do

    erb :"/territories/sign_in_or_out"
  end

  post '/territories/sign_in_or_out' do

    redirect :"/users/show_user"
  end

end
