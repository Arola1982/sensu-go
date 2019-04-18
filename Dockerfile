FROM sensu/sensu:5.5.0

RUN apk add ruby ruby-dev

RUN wget -O /opt/master.zip https://github.com/sensu-plugins/sensu-plugins-kubernetes/archive/master.zip

WORKDIR /opt

RUN unzip *.zip

WORKDIR /opt/sensu-plugins-kubernetes-master

RUN gem build sensu-plugins-kubernetes

RUN gem install sensu-plugins-kubernetes
