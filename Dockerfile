ARG IMAGE_SOURCE_TAG=latest
FROM sensu/sensu:$IMAGE_SOURCE_TAG

MAINTAINER Adam Copley <adam.copley@arola.co.uk>

RUN apk add \
  ruby \
  ruby-rdoc \
  ruby-dev \
  curl \
  bash \
  make \
  gcc \
  libc-dev \
  g++ \
  libxml2-dev \
  zlib-dev \
  sed \
  jq

# Add community plugins repo to be able to install plugins using gem
RUN curl -s https://packagecloud.io/install/repositories/sensu/community/script.gem.sh | bash

# Download handlers
RUN mkdir /tmp/download && \
  curl -L -o /tmp/download/sensu-email-handler_0.1.0_linux_amd64.tar.gz https://github.com/sensu/sensu-email-handler/releases/download/0.1.0/sensu-email-handler_0.1.0_linux_amd64.tar.gz && \
  curl -L -o /tmp/download/sensu-influxdb-handler_3.1.2_linux_amd64.tar.gz https://github.com/sensu/sensu-influxdb-handler/releases/download/3.1.2/sensu-influxdb-handler_3.1.2_linux_amd64.tar.gz && \
  cd /tmp/download && \
  for HANDLER in `ls -1 *.gz` ; do tar -xvzf $HANDLER ; done && \
  mv bin/* /usr/bin/ && \
  cd /tmp && \
  rm -rf download

# Include plugins
RUN gem install sensu-plugins-kubernetes && \
  gem install sensu-plugins-http && \
  gem install sensu-plugins-aws
