FROM nextcloud:apache

RUN apt-get update && apt-get install -y \
    supervisor procps smbclient php-redis \
    libmagickcore-6.q16-6-extra \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
