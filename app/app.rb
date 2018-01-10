ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require 'dotenv/load'

require_relative 'data_mapper_setup'

require_relative 'server'
require_relative './controllers/init'
