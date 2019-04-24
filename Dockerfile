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

COPY check_kubernetes.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/check_kubernetes.sh

RUN curl -s https://packagecloud.io/install/repositories/sensu/community/script.gem.sh | bash

RUN gem install sensu-plugins-kubernetes
