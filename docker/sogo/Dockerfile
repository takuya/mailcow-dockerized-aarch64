FROM debian:bullseye-slim
LABEL maintainer "Andre Peters <andre.peters@servercow.de>"

ARG DEBIAN_FRONTEND=noninteractive
ARG SOGO_DEBIAN_REPOSITORY=http://packages.sogo.nu/nightly/5/debian/
ENV LC_ALL C
ENV GOSU_VERSION 1.14

# Prerequisites
RUN echo "Building from repository $SOGO_DEBIAN_REPOSITORY" \
  && apt-get update && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  gettext \
  gnupg \
  mariadb-client \
  rsync \
  supervisor \
  syslog-ng \
  syslog-ng-core \
  syslog-ng-mod-redis \
  dirmngr \
  netcat \
  psmisc \
  wget \
  patch \
  && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
  && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true \
  && mkdir /usr/share/doc/sogo \
  && touch /usr/share/doc/sogo/empty.sh \
  && touch /etc/default/locale

## for arm64
RUN echo 'enable sid,testing' \
  && echo 'deb http://ftp.jp.debian.org/debian testing main contrib non-free' >> /etc/apt/sources.list \
  && echo 'deb-src http://ftp.jp.debian.org/debian testing main contrib non-free' >>  /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y sogo/testing sogo-activesync/testing \
  && apt-get autoclean;

RUN usermod -d /var/lib/sogo sogo
RUN mkdir -p   /var/lib/sogo/GNUstep/Defaults/ \
  && touch /var/lib/sogo/GNUstep/Defaults/sogod.plist \
  && chown -R sogo:sogo   /var/lib/sogo  \
  && mkdir -p /var/run/sogo/ \
  && touch /var/run/sogo/sogo.pid \
  && chown -R sogo:sogo   /var/run/sogo


RUN echo 'install debug tools ' \
  && apt-get update \
  && apt-get install -y curl vim-nox procps \
  && apt-get autoclean;


COPY ./bootstrap-sogo.sh /bootstrap-sogo.sh
COPY syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
COPY syslog-ng-redis_slave.conf /etc/syslog-ng/syslog-ng-redis_slave.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY acl.diff /acl.diff
COPY stop-supervisor.sh /usr/local/sbin/stop-supervisor.sh
COPY docker-entrypoint.sh /

RUN chmod +x /bootstrap-sogo.sh \
  /usr/local/sbin/stop-supervisor.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf