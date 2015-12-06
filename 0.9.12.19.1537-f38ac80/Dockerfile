FROM progrium/busybox

MAINTAINER vSense <docker@vsense.fr> (@archifleks)

ENV PKGVER 0.9.12.19.1537-f38ac80

RUN opkg-install libstdcpp \
    && wget http://downloads.plex.tv/plex-media-server/"$PKGVER"/plexmediaserver_"$PKGVER"_amd64.deb -P /tmp \
    && cd /tmp \
    && ar vx plexmediaserver_"$PKGVER"_amd64.deb \
    && gzip -d data.tar.gz \
    && tar xf data.tar \
    && mv ./usr/lib/plexmediaserver /opt/. \
    && rm -rf /tmp/* \
    && mkdir -p /config /library \
    && adduser -D -h /config -s /sbin/nologin -u 5001 plex \
    && chown -R plex:plex /config /library \
    && ln -s /lib/lib.so.6 /opt/plexmediaserver/libc.so

COPY start.sh /start.sh

RUN chmod +x start.sh

VOLUME /config /library

EXPOSE 32400

CMD ["/start.sh"]
