FROM debian:jessie
MAINTAINER Jimmy Cuadra <jimmy@jimmycuadra.com>

RUN echo 'gem: --no-document' > /usr/local/etc/gemrc && \
  echo 'locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8' | debconf-set-selections && \
  echo 'locales locales/default_environment_locale select en_US.UTF-8' | debconf-set-selections

ENV RUBY_MAJOR_MINOR_VERSION 2.2
ENV RUBY_VERSION 2.2.2
ENV RUBY_TARBALL_SHA512 d6693251296e9c6e8452786ce6b0447c8730aff7f92d0a92733444dbf298a1e7504b7bd29bb6ee4f2155ef94ccb63148311c3ed7ac3403b60120a3ab5c70a162
ENV GEM_HOME /usr/local/lib/ruby/gems/${RUBY_MAJOR_MINOR_VERSION}.0

RUN apt-get -qq update && \
  DEBIAN_FRONTEND=noninteractive apt-get -qy --no-install-recommends install \
    build-essential \
    ca-certificates \
    curl \
    libffi-dev \
    libreadline6-dev \
    libssl-dev \
    libyaml-dev \
    locales \
    zlib1g-dev && \
  curl -s -O http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR_MINOR_VERSION/ruby-$RUBY_VERSION.tar.bz2 && \
  [ $(sha512sum ruby-$RUBY_VERSION.tar.bz2 | awk '{ print $1 }') = $RUBY_TARBALL_SHA512 ] && \
  tar -jxf ruby-$RUBY_VERSION.tar.bz2 && \
  cd ruby-$RUBY_VERSION && \
  ./configure --disable-install-doc && \
  make -j$(nproc) && \
  make install && \
  gem update --system && \
  cd .. && \
  rm -rf ruby-$RUBY_VERSION ruby-$RUBY_VERSION.tar.bz2 /tmp/* /var/tmp/* && \
  apt-get -qy clean autoclean autoremove && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV LANG en_US.UTF-8
