FROM dannyben/alpine-ruby

RUN gem install sla --version 0.3.5

WORKDIR /app
VOLUME /app/cache

ENTRYPOINT ["sla"]