require 'sinatra/base'
require 'pry'

require './db/setup'
require './lib/all'

class App < Sinatra::Base
  set :logging, true

  def current_user
    User.find 1
  end

  get "/" do
    "It works!"
  end

  # HTML section

  get "/lists/:list_id" do
    list = current_user.lists.find params[:list_id]
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
    list = current_user.lists.find params[:list_id]
    { id:    list.id,
      name:  list.name,
      items: list.items }.to_json
  end

  post "/api/lists/:list_id/todos" do
    list = List.find params[:list_id]
    if list.user == current_user
      i = Item.new(
        name:    params[:item_name],
        list_id: params[:list_id]
      )
      if i.save
        i.to_json
      else
        status 422
        body({ error: i.errors.full_messages.to_sentence }.to_json)
      end
    else
      status 403
      body({ error: "Not allowed to modify this list" }.to_json)
    end
  end
end

App.run!
