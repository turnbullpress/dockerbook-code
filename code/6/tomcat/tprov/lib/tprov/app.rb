$: << File.dirname(__FILE__)

require 'sinatra'
require 'sinatra/url_for'
require 'sinatra/static_assets'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'json'
require 'uri'

module TProv
  class Application < Sinatra::Base

    register Sinatra::StaticAssets
    register Sinatra::Flash
    helpers Sinatra::RedirectWithFlash

    set :public_folder, File.join(File.dirname(__FILE__), 'public')
    set :views, File.join(File.dirname(__FILE__), 'views')
    set :bind, '0.0.0.0'

    enable :sessions, :logging, :dump_errors, :raise_errors, :show_exceptions

    before do
      @app_name = "TProv"
    end

    get '/' do
      erb :index
    end

    post '/tomcat/create' do
      if params[:name].empty? or params[:url].empty?
        redirect '/', :error => "You must specify a name and a URL."
      end
      success, output = get_war(params[:name], params[:url])
      unless success
        redirect '/', :error => "Tomcat application #{params[:name]} failed to be fetched because #{output}."
      end
      success, output = create_instance(params[:name])
      unless success
        redirect '/', :error => "Tomcat application #{params[:name]} failed to be created because #{output}."
      end
      redirect '/', :success => "Tomcat Application #{params[:name]} created!"
    end

    post '/tomcat/delete' do
      success, output = delete_instance(params[:id])
      unless success
        redirect '/', :error => "Tomcat application #{params[:name]} failed to be deleted because #{output}."
      end
      redirect '/', :success => "Instance #{params[:id]} deleted!"
    end

    get '/tomcat/list' do
      @instances = list_instances
      erb :instance_list
    end

    helpers do
      def get_war(name, url)
        cid = `docker run --name "#{name}" jamtur01/fetcher "#{url}" 2>&1`.chop
        puts cid
        [$?.exitstatus == 0, cid]
      end

      def create_instance(name)
        cid = `docker run -P --volumes-from "#{name}" -d -t jamtur01/tomcat8 2>&1`.chop
        [$?.exitstatus == 0, cid]
      end

      def delete_instance(cid)
        kill = `docker kill #{cid} 2>&1`
        [$?.exitstatus == 0, kill]
      end

      def list_instances
        @list = {}
        instance_ids = `docker ps -q`.split(/\n/).reject(&:empty?)
        instance_ids.each { |id|
          port = `docker port #{id} 8080`.chop
          config = JSON.parse(`docker inspect #{id}`)
          @list[id] = { 'hostname' => config[0]["Config"]["Hostname"], 'ip' => config[0]["NetworkSettings"]["IPAddress"], 'port' => port }
        }
        @list
      end
    end

  end
end
