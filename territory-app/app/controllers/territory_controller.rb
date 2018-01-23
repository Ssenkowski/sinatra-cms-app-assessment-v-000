require 'pry'
class TerritoryController < ApplicationController

  get '/territories' do

    erb :"/territories/territories"
  end

  get '/territories/new' do

    erb :'/territories/new'
  end

  post '/territories/new' do

    erb :'/territories/new'
  end

  get "/territories/:id" do

    redirect "/territories/show_territory"
  end

  patch '/territories/:id/edit' do

    redirect "/territories/#{@territory.id}"
  end

  get '/territories/sign_in_or_out' do

     :"/territories/sign_in_or_out"
  end

  post '/territories/sign_in_or_out' do

    redirect :"/users/show_user"
  end

end
