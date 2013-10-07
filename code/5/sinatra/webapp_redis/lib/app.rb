require "rubygems"
require "sinatra"
require "json"
require "redis"

class App < Sinatra::Application

      redis = Redis.new(:host => 'db', :port => '6379')

      set :bind, '0.0.0.0'

      get '/' do
        "<h1>DockerBook Test Redis-enabled Sinatra app</h1>"
      end

      get '/json' do
        params = redis.get "params"
        params.to_json
      end

      post '/json/?' do
        redis.set "params", [params].to_json
        params.to_json
      end
end
