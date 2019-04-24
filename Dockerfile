FROM sensu/sensu:5.5.0

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
  jq \
  openssl

RUN curl -s https://packagecloud.io/install/repositories/sensu/community/script.gem.sh | bash

RUN gem install sensu-plugins-kubernetes
