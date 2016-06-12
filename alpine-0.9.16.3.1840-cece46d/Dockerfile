FROM vsense/baseimage:alpine-glibc

MAINTAINER vSense <docker@vsense.fr> (@archifleks)

ENV PKGVER 0.9.16.3.1840-cece46d

RUN apk add --update \
        supervisor \
        && apk add --update --virtual deps \
        dpkg \
        tar \
        && wget http://downloads.plex.tv/plex-media-server/"$PKGVER"/plexmediaserver_"$PKGVER"_amd64.deb -P /tmp \
    && cd /tmp \
    && dpkg -x plexmediaserver_"$PKGVER"_amd64.deb . \
    && mkdir -p /opt \
    && mv ./usr/lib/plexmediaserver /opt/. \
    && rm -rf /tmp/* \
    && mkdir -p /config /library \
    && adduser -D -h /config -s /sbin/nologin -u 5001 plex \
    && chown -R plex:plex /config /library \

VOLUME /config /library

EXPOSE 32400

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
