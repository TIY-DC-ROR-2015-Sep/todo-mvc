require 'sinatra/base'
require 'pry'

require './db/setup'
require './lib/all'

class App < Sinatra::Base
  set :logging, true

  get "/" do
    "It works!"
  end

  get "/lists/:list_id" do
    list = List.find params[:list_id]
    erb :list, locals: { list: list }
  end
end

App.run!
