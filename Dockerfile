FROM sensu/sensu:5.5.0

RUN apk add \
  ruby \
  ruby-dev \
  curl

RUN curl -s https://packagecloud.io/install/repositories/sensu/community/script.gem.sh | bash
