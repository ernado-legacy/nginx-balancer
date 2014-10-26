FROM cydev/nginx

MAINTAINER Alexandr Razumov ernado@ya.ru

# setting environment variables
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH   $PATH:$GOPATH/bin:$GOROOT/bin

# installing deps
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        curl \
        mercurial \
        meld \
        git \
    && apt-get clean

# installing golang
ENV VERSION 1.3.3
ENV LINK    https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz
RUN curl -s ${LINK} | tar -v -C /usr/local/ -xz

RUN go get -v github.com/kelseyhightower/confd
RUN go get -v github.com/coreos/etcdctl

# copying config files and templates
ADD nginx.toml /etc/confd/conf.d/
ADD nginx.tmpl /etc/confd/templates/
ADD run.sh /usr/bin/run.sh

ENTRYPOINT ["run.sh"]