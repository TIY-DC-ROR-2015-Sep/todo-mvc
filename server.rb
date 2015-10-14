require 'sinatra/base'
require 'pry'

require './db/setup'
require './lib/all'

class App < Sinatra::Base
  set :logging, true

  get "/" do
    "It works!"
  end

  # HTML section

  get "/lists/:list_id" do
    list = List.find params[:list_id]
    erb :list, locals: { list: list }
  end

  post "/lists/:list_id/todos" do
    Item.create(
      name:    params[:item_name],
      list_id: params[:list_id]
    )
    redirect to("/lists/#{params[:list_id]}")
  end

  # JSON API

  get "/api/lists/:list_id" do
    list = List.find params[:list_id]
    { id:    list.id,
      name:  list.name,
      items: list.items }.to_json
  end

  post "/api/lists/:list_id/todos" do
    i = Item.create(
      name:    params[:item_name],
      list_id: params[:list_id]
    )
    i.to_json
  end
end

App.run!
