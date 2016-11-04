require 'pry'
require 'sinatra'
# require 'sinatra/reloader'
require_relative 'db_config'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'fog'
require_relative 'models/sighting'
require_relative 'models/user'
require_relative 'models/country'
require_relative 'models/comment'

## SESSION METHODS

enable :sessions #creates session as a global object - basically a hash
#it just store the current user_id once logged in
#user_id is a made up thing
#can also put :last_url so that the website remembers the last page they were on and go back to it after logged in
#session[:user]

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
  #put a binding.pry here and then type in request in pry where the program is stopped
  #could do request.path
  # request.referrer
  #request.port
  #request.host
  @countries = Country.all
  # binding.pry
  erb :index
end

#shows the new report form if logged in or redirects to sign up page o
get '/sightings/new' do
  redirect to '/session/new' unless logged_in? #can only add entry if logged in
  @sightings = Sightings.all
  erb :sightings_new
end

#creates the new post
post '/sightings/all' do
    @sighting = Sighting.create(name: params[:name], image_url: params[:image_url], country_id: params[:country_id], user_id: current_user.id, date: params[:date], picture: params[:picture])
    binding.pry
    redirect to '/'
end

#shows sightings
get '/sightings/all' do
  if params[:country_id]
    #this shows trips of c
    @sightings = Sighting.where(country_id: params[:country_id])
  else
    @sightings = Sighting.select do | sighting |
      sighting.user_id != nil
    end
  end
  erb :sightings_all
end

#shows list of countries
get '/map' do
  @countries = Country.all
  erb :map
end

#show single sighting -  search for post with that id
get '/sightings/all/:id' do
  #show single sighting -  search for sighting with that id
  @sighting = Sighting.find(params[:id])
  @comments = Comment.where(sighting_id: @sighting['id'])
  erb :sightings_show
end


#this brings up the edit form when ever you click edit
get '/sightings/all/:id/edit' do
  @countries = Country.all
  @sighting = Sighting.find(params[:id])
  erb :sightings_edit
end


#posts the new update when you click the update button
post '/sightings/all/:id' do
  #sql statment to update an existing dish
  #update dishes set name = '', image_url = '' where id = 7
  @sighting = Sighting.find(params[:id])
  @sighting.update(name: params[:name], image_url: params[:image_url], country_id: params[:country_id], date: params[:date])
  redirect to "/sightings/all/#{ params[:id] }"
end

#posts the comment when the form/post comment action button is triggered
post '/comments' do
  comment = Comment.create(body: params[:body], sighting_id: params[:sighting_id], user_id: current_user.id)
  # #commmment = Comment.new
  # commmment.user_id = current_user.id
  redirect to "/sightings/all/#{comment['sighting_id']}"
end

#report a sighting or join to report page
get '/join' do
  @countries = Country.all
  erb :join
end

#create new user when register form is submitted
post '/register' do
  @user = User.new(first: params[:first], email: params[:email], username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
    # @user.errors.messages
  else
    erb :join
  end
end

#if there isnt

#sign in page
get '/session/new' do
  erb :session_new
end

#verify user details
post '/session' do
  @errormessage = ""
  user = User.find_by(username: params[:username])  ##if cant find the user in the database it will return NIL
  if user && user.authenticate(params[:password])
    #you are in the database, let me create a session for you
    session[:user_id] = user.id  #write the user id to the session
    redirect '/'
  else
    @errormessage = "Sorry not recognized"
    #not recoginised
    erb :session_new
  end
end


delete '/session' do
  #clearing the session
  session[:user_id] = nil
  redirect to '/session/new'
end


#PROFILE

get '/profile/:id' do
  @user = User.find(params[:id])
  erb :profile
end

#EDIT profile

get '/profile/:id/edit' do
  @user = User.find(params[:id])
  erb :profile_edit
end


#SUBMIT CHANGES

post '/profile/:id' do
  @user = User.find(params[:id])
  # @user.update(first: params[:first], email: params[:email], profilepic: params[:profilepic])

  @user.profilepic = params[:profilepic]
  @user.save
  binding.pry
  erb :profile
end
