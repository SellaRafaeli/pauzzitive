puts "starting app..."

require 'bundler'

require 'active_support'
require 'active_support/core_ext'

require 'sinatra/reloader' #dev-only
require 'sinatra/activerecord'

puts "requiring gems..."

Bundler.require

Dotenv.load

require './setup'
require './my_lib'

require_all './db'
require_all './mw'
require_all './comm'
require_all './bl'
require_all './admin'
require_all './logging'

include Helpers

get '/ping' do
  {msg: 'pong from pauzzitive', val: 123}
end

get '/webhook' do
  handle_msg_wrapper  
end

post '/webhook' do
  handle_msg_wrapper
end

get '/' do
  redirect '/admin'
end