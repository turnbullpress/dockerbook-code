$: << File.dirname(__FILE__)

require 'sinatra'
require 'sinatra/url_for'
require 'sinatra/static_assets'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'pp'
require 'redis'
require 'json'

module WProv
  class Application < Sinatra::Base

    @db = Redis.new

    register Sinatra::StaticAssets
    register Sinatra::Flash
    helpers Sinatra::RedirectWithFlash

    set :public_folder, File.join(File.dirname(__FILE__), 'public')
    set :views, File.join(File.dirname(__FILE__), 'views')

    enable :sessions

    configure :production do
      log = File.new("log/production.log", "a")
      STDOUT.reopen(log)
      STDERR.reopen(log)
    end

    enable :logging, :dump_errors, :raise_errors, :show_exceptions

    before do
      @app_name = "WProv"
    end

    get '/' do
      erb :index
    end

    post '/wordpress/create' do
      create_instance(params)
      redirect '/', :success => 'Instance created!'
    end

    post '/wordpress/delete' do
      #delete_instance
      redirect '/', :success => 'Instance deleted!'
    end

    get '/wordpress/list' do
      @instances = list_instances
      pp @instances
      erb :instance_list
    end

    helpers do
      def errors(obj)
        tmp = []
        obj.errors.each do |e|
          tmp << e
        end
        tmp
      end

      def link_to(name, location, alternative = false)
        if alternative and alternative[:condition]
          "<a href=#{alternative[:location]}>#{alternative[:name]}</a>"
        else
          "<a href=#{location}>#{name}</a>"
        end
      end

      def create_instance(params)
        domain = ".container.io"
        name = params[:name] + domain
        #cid = `docker run -d -t jamtur01/wordpress`
        #ipaddr = `docker inspect #{cid}`
        #port = `docker port #{cid} 80`
        name
      end

      def delete_instance(instance_id)
        kill = `docker stop #{instance_id}`
      end

      def list_instances
        #instances = `docker ps`
        [ 'a', 'b', 'c' ]
      end
    end

  end
end
