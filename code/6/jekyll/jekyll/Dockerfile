# Jekyll Base Image
FROM ubuntu:14.04
MAINTAINER James Turnbull <james@example.com>

ENV RUBY_MAJOR 2.0
ENV RUBY_VERSION 2.0.0-p648
ENV RUBY_DOWNLOAD_SHA256 8690bd6b4949c333b3919755c4e48885dbfed6fd055fe9ef89930bde0d2376f8
ENV RUBYGEMS_VERSION 2.5.1

# skip installing gem documentation
RUN echo 'install: --no-document\nupdate: --no-document' > "$HOME/.gemrc"

# some of ruby's build scripts are written in ruby
# we purge this later to make sure our final image uses what we just built
RUN apt-get update \
	&& apt-get install -y bison libgdbm-dev ruby curl\
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/ruby \
	&& curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
	&& echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c - \
	&& tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.gz \
	&& cd /usr/src/ruby \
	&& autoconf \
	&& ./configure --disable-install-doc \
	&& make -j"$(nproc)" \
	&& make install \
	&& apt-get purge -y --auto-remove bison libgdbm-dev ruby \
	&& gem update --system $RUBYGEMS_VERSION \
	&& rm -r /usr/src/ruby

# install things globally, for great justice
ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH

ENV BUNDLER_VERSION 1.11.2

RUN gem install i--no-rdoc --no-ri bundler --version "$BUNDLER_VERSION" \
	&& bundle config --global path "$GEM_HOME" \
	&& bundle config --global bin "$GEM_HOME/bin" \
	&& jekyll -v 2.5.3

# don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME

VOLUME /data
VOLUME /var/www/html
WORKDIR /data

ENTRYPOINT [ "jekyll", "build", "--destination=/var/www/html" ]
