FROM dannyben/alpine-ruby

RUN gem install sla --version 0.3.3

WORKDIR /app
VOLUME /app/cache

ENTRYPOINT ["sla"]