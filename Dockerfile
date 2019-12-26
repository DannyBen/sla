FROM dannyben/alpine-ruby

RUN gem install sla

ENTRYPOINT ["sla"]