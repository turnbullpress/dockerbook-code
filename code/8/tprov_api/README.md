# TProv

**TProv** or the Tomcat Provisioner is a
 [Sinatra](http://www.sinatrarb.com) app that demonstrates how to build
a simple PAAS with Docker. It allows you to provision Tomcat
applications running in Docker containers.

## Running standalone

Simply run the ``bundle`` and then ``rackup`` commands.

## Bundling as a gem

    gem build tprov.gemspec
    sudo gem install tprov-0.0.1.gem
