$: << File.dirname(__FILE__)

require 'sinatra/base'
require 'sinatra/url_for'
require 'sinatra/static_assets'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require 'json'
require 'uri'
require 'docker'
require 'pp'

module TProv
  class Application < Sinatra::Base

    register Sinatra::StaticAssets
    register Sinatra::Flash
    helpers Sinatra::RedirectWithFlash

    set :public_folder, File.join(File.dirname(__FILE__), 'public')
    set :views, File.join(File.dirname(__FILE__), 'views')
    set :bind, '0.0.0.0'

    Docker.url = ENV['DOCKER_URL'] || 'https://localhost:2375'
    Docker.options = {
      :ssl_verify_peer => false
    }

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
        container = Docker::Container.create('Cmd' => url, 'Image' => 'jamtur01/fetcher', 'name' => name)
        container.start
        container.id
      end

      def create_instance(name)
        container = Docker::Container.create('Image' => 'jamtur01/tomcat7')
        container.start('PublishAllPorts' => true, 'VolumesFrom' => name)
        container.id
      end

      def delete_instance(cid)
        container = Docker::Container.get(cid)
        container.kill
      end

      def list_instances
        @list = {}
        instance_ids = Docker::Container.all
        instance_ids.each { |id|
          container = Docker::Container.get(id.id)
          config = container.json
          if config['NetworkSettings']['Ports']['8080/tcp']
            @list[id] = { 'hostname' => config['Config']['Hostname'], 'ip' => config['NetworkSettings']['IPAddress'], 'port' => config['NetworkSettings']['Ports']['8080/tcp'][0]['HostPort'] }
          end
        }
        @list
      end
    end

  end
end
