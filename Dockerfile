FROM progrium/busybox

MAINTAINER vSense <docker@vsense.fr> (@archifleks)

RUN opkg-install wget curl ca-certificates jsonfilter \
    && PKGVER=`curl 'https://plex.tv/api/downloads/1.json?channel=plexpass' | jsonfilter -e '@.computer.Linux.version'` \
    && wget https://downloads.plex.tv/plex-media-server/"$PKGVER"/plexmediaserver_"$PKGVER"_amd64.deb -P /tmp \
    && cd /tmp \
    && ar vx plexmediaserver_"$PKGVER"_amd64.deb \
    && gzip -d data.tar.gz \
    && tar xf data.tar \
    && mv ./usr/lib/plexmediaserver /opt/. \
    && rm -rf /tmp/* \
    && mkdir -p /config /library \
    && adduser -D -h /config -s /sbin/nologin -u 5001 plex \
    && chown -R plex:plex /config /library \
    && ln -s /lib/libc.so.6 /opt/plexmediaserver/libc.so

COPY start.sh /start.sh

COPY libstdc++.so.6.0.21 /usr/lib/libstdc++.so.6.0.21

RUN ln -s /usr/lib/libstdc++.so.6.0.21 /usr/lib/libstdc++.so.6

RUN chmod +x start.sh

VOLUME /config /library

EXPOSE 32400

CMD ["/start.sh"]
