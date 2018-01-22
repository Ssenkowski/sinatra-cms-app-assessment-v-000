require 'pry'
class TerritoryController < ApplicationController

  get '/territories' do

    erb :"/territories/territories"
  end

  get '/territories/new' do

    erb :'/territories/new'
  end

  get '/territories/sign_in_or_out' do

    erb :"/territories/sign_in_or_out"
  end

end
