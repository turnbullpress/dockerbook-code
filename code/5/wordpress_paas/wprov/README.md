# WProv

**WProv** or the Wordpress Provisioner is a
 [Sinatra](http://www.sinatrarb.com) app that demonstrates how to build
a simple PAAS with Docker. It allows you to provision multiple custom
Wordpress instances running in Docker containers.

## Running standalone

Simply run the ``bundle`` and then ``rackup`` commands.

## Bundling as a gem

    gem build wprov.gemspec
    sudo gem install wprov-0.0.1.gem
