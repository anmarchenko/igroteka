FROM bitwalker/alpine-elixir:1.12.3 as builder

# Upgrade the apk-tools to the newest version and everything installed
RUN apk add --no-cache --upgrade apk-tools@main && apk upgrade --available
# Add packages to compile NIFs
RUN apk add --no-cache g++@main gcc@main make@main libgcc@main libc-dev@main

WORKDIR /opt/app

COPY ./config/* ./config/
COPY mix.exs mix.lock ./

ENV MIX_ENV=prod
RUN mix do deps.get, deps.compile

COPY . .

RUN mix release

FROM alpine:3.14.2

ENV PORT 4000
ENV HOME /opt/app
ENV PATH ${HOME}/bin:${PATH}

ARG BUILD_RELEASE=/opt/app/_build/prod/rel/skaro
ARG BUILD_ENTRYPOINT=/opt/app/docker-entrypoint.sh

RUN \
  # Create default user and home directory, set owner to default
  mkdir -p "${HOME}" && \
  adduser -s /bin/sh -u 1001 -G root -h "${HOME}" -S -D default && \
  chown -R 1001:0 "${HOME}" && \
  # Add tagged repos as well as the edge repo so that we can selectively install edge packages
  echo "@main http://dl-cdn.alpinelinux.org/alpine/v3.14/main" >> /etc/apk/repositories && \
  echo "@community http://dl-cdn.alpinelinux.org/alpine/v3.42/community" >> /etc/apk/repositories && \
  echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
  # Upgrade Alpine and base packages
  apk --no-cache --update --available upgrade && \
  # Distillery requires bash - install bash and Erlang/OTP deps
  apk add --no-cache --update pcre@edge && \
  apk add --no-cache --update \
  bash \
  ca-certificates \
  openssl-dev \
  ncurses-dev \
  unixodbc-dev \
  zlib-dev \
  g++@main \
  gcc@main \
  libgcc@main \
  libc-dev@main

WORKDIR ${HOME}

# Copy files from builder
COPY --from=builder ${BUILD_RELEASE} ./
COPY --from=builder ${BUILD_ENTRYPOINT} docker-entrypoint.sh
# Extract files and fix permissions
RUN chmod +x docker-entrypoint.sh && \
  chown -R default .

ONBUILD USER default

EXPOSE ${PORT}

ENTRYPOINT ["/opt/app/docker-entrypoint.sh"]
CMD ["init"]
