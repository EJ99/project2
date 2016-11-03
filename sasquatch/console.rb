require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'fog'
require_relative 'models/sighting'
require_relative 'models/comment'
require_relative 'models/country'
require_relative 'models/user'

binding.pry
