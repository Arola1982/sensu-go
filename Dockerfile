FROM sensu/sensu:5.16.1

MAINTAINER Adam Copley <adam.copley@arola.co.uk>

RUN apk add --no-cache \
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
  curl -L -o /tmp/download/sensu-email-handler_0.2.0_linux_amd64.tar.gz https://github.com/sensu/sensu-email-handler/releases/download/0.2.0/sensu-email-handler_0.2.0_linux_amd64.tar.gz && \
  curl -L -o /tmp/download/sensu-influxdb-handler_3.1.2_linux_amd64.tar.gz https://github.com/sensu/sensu-influxdb-handler/releases/download/3.1.2/sensu-influxdb-handler_3.1.2_linux_amd64.tar.gz && \
  cd /tmp/download && \
  for HANDLER in `ls -1 *.gz` ; do tar -xvzf $HANDLER ; done && \
  mv bin/* /usr/bin/ && \
  cd /tmp && \
  rm -rf download

# Download kubectl for interacting with AWS
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin/kubectl

# Include dependencies
RUN gem install bigdecimal
RUN gem install aws-sdk-sso

# Include plugins
RUN gem install sensu-plugins-kubernetes
RUN gem install sensu-plugins-http
RUN gem install sensu-plugins-network-checks
RUN gem install sensu-plugins-aws
RUN gem install sensu-plugins-xmpp
RUN gem install sensu-plugins-rocket-chat
RUN gem install sensu-plugins-microsoft-teams
RUN gem install sensu-plugins-hipchat
