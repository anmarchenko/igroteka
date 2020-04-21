FROM bitwalker/alpine-elixir:1.10.2 as builder

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

RUN mix distillery.release --env=prod --verbose
RUN cp _build/prod/rel/*/releases/*/*.tar.gz _build/prod/rel/current_release.tar.gz

FROM alpine:3.10.2

ENV VERSION_DATE=2019-03-04
ENV PORT 4000
ENV REPLACE_OS_VARS true
ENV HOME /opt/app
ENV PATH ${HOME}/bin:${PATH}

ARG BUILD_RELEASE=/opt/app/_build/prod/rel/current_release.tar.gz
ARG BUILD_ENTRYPOINT=/opt/app/docker-entrypoint.sh

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
