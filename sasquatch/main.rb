require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'
require_relative 'models/sighting'
require_relative 'models/user'
require_relative 'models/country'
require_relative 'models/comment'

## SESSION METHODS

enable :sessions #creates session as a global object - basically a hash

helpers do
  def logged_in?
    !!current_user #same as if/else statment below
    # if current_user
    #   true
    # else
    #   false
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end

## GET/POST METHODS

get '/' do
  erb :index
end

get '/sightings/new' do  #shows the form only
  redirect to '/session/new' unless logged_in? #can only add entry if logged in
  @sightings = Sightings.all
  erb :sightings_new
end

post '/sightings' do  #creates the post only
    @sighting = Sighting.create(name: params[:name], image_url: params[:image_url], country_id: params[:continent_id], date: params[:date])
    redirect to '/'
end

get '/sightings/all' do
  if params[:country_id]
    #this shows trips of c
    @sightings = Sighting.where(country_id: params[:country_id])
  else
    @sightings = Sighting.all
  end
  erb :sightings_all
end

get '/map' do
  @countries = Country.all
  erb :map
end

#show single sighting -  search for post with that id
get '/sightings/:id' do
  #show single dish -  search for dish with that id
  @sighting = Sighting.find(params[:id])
  @comments = Comment.where(sighting_id: @sighting['id'])
  erb :sightings_show
end


#this is posting the new update when you click the update button
post '/sightings/:id' do
  #sql statment to update an existing dish
  #update dishes set name = '', image_url = '' where id = 7
  @sighting = Sighting.find(params[:id])
  @sighting.update(name: params[:name], image_url: params[:image_url], country_id: params[:country_id], date: params[:date])
  redirect to "/sightings/#{ params[:id] }"
end

#posts the comment when the form/post comment action button is triggered
post '/comments' do
  comment = Comment.create(body: params[:body], sighting_id: params[:sighting_id])
  redirect to "/sightings/#{comment['sighting_id']}"
end

get '/join' do
  erb :join
end

post '/register' do
  user = User.create(first: params[:first], email: params[:email], username: params[:username], password: params[:password])
  session[:user_id] = user.id
  redirect '/'
end

get '/session/new' do
  erb :session_new
end

post '/session' do
  user = User.find_by(username: params[:username])  ##if cant find the user in the database it will return NIL
  if user && user.authenticate(params[:password])
    #you are in the database, let me create a session for you
    session[:user_id] = user.id
    redirect '/'
  else
    #not recoginised
    erb :session_new
  end
end

delete '/session' do
  #clearing the session
  session[:user_id] = nil
  redirect to '/session/new'
end
