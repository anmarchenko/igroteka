FROM bitwalker/alpine-elixir:1.8.1

# Upgrade the apk-tools to the newest version and everything installed
RUN apk add --no-cache --upgrade apk-tools@edge && apk upgrade --available
# Add packages to compile NIFs
RUN apk add --no-cache g++@main gcc@main make@main libgcc@main libc-dev@main

WORKDIR /opt/app

COPY ./config/* ./config/
COPY mix.exs mix.lock ./

ENV MIX_ENV=prod
RUN mix do deps.get, deps.compile

COPY . .

RUN mix release --env=prod --verbose
RUN cp _build/prod/rel/*/releases/*/*.tar.gz _build/prod/rel/current_release.tar.gz

FROM alpine:3.9

ENV VERSION_DATE=2019-03-04
ENV PORT 4000
ENV REPLACE_OS_VARS true
ENV HOME /opt/app
ENV PATH ${HOME}/bin:${PATH}

ONBUILD ARG BUILD_RELEASE=/opt/app/_build/prod/rel/current_release.tar.gz
ONBUILD ARG BUILD_ENTRYPOINT=/opt/app/docker-entrypoint.sh

RUN \
  # Create default user and home directory, set owner to default
  mkdir -p "${HOME}" && \
  adduser -s /bin/sh -u 1001 -G root -h "${HOME}" -S -D default && \
  chown -R 1001:0 "${HOME}" && \
  # Add tagged repos as well as the edge repo so that we can selectively install edge packages
  echo "@main http://dl-cdn.alpinelinux.org/alpine/v3.9/main" >> /etc/apk/repositories && \
  echo "@community http://dl-cdn.alpinelinux.org/alpine/v3.9/community" >> /etc/apk/repositories && \
  echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
  # Upgrade Alpine and base packages
  apk --no-cache --update --available upgrade && \
  # Distillery requires bash Install bash and Erlang/OTP deps
  apk add --no-cache --update pcre@edge && \
  apk add --no-cache --update \
  bash \
  ca-certificates \
  openssl-dev \
  ncurses-dev \
  unixodbc-dev \
  zlib-dev

WORKDIR ${HOME}

# Copy files from builder
COPY --from=builder ${BUILD_RELEASE} current_release.tar.gz
COPY --from=builder ${BUILD_ENTRYPOINT} docker-entrypoint.sh
# Extract files and fix permissions
RUN tar -xzf ./current_release.tar.gz && \
  rm ./current_release.tar.gz && \
  chmod +x docker-entrypoint.sh && \
  chown -R default .

ONBUILD USER default

EXPOSE ${PORT}

ENTRYPOINT ["/opt/app/docker-entrypoint.sh"]
CMD ["init"]




FROM bitwalker/alpine-elixir:1.8.1 as builder

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
