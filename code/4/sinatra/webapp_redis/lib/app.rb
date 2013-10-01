require "rubygems"
require "sinatra"
require "json"
require "redis"

class App < Sinatra::Application

      redis = Redis.new(:host => "172.17.0.18", :port => 6379)

      set :bind, '0.0.0.0'

      post '/json/?' do
        redis.set "params", [params].to_json
        params.to_json
      end
end
