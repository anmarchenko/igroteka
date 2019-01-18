FROM bitwalker/alpine-elixir:1.8.0 as builder

ENV VERSION=2019-01-18
ENV HOME=/opt/app/ TERM=xterm

WORKDIR /opt/app

ENV MIX_ENV=prod

# Cache elixir deps
RUN mkdir config
COPY config/* config/
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

RUN mix release --env=prod --verbose

# Production image
FROM bitwalker/alpine-erlang:21

EXPOSE 4000
ENV PORT=4000 MIX_ENV=prod REPLACE_OS_VARS=true SHELL=/bin/sh

COPY --from=builder /opt/app/_build/prod/rel/skaro/releases/0.0.1/skaro.tar.gz ./skaro.tar.gz
RUN tar -xzf ./skaro.tar.gz
RUN chown -R default .

USER default

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["init"]
