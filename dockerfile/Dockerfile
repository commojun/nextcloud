FROM nextcloud:apache

RUN apt-get update && apt-get install -y \
    ffmpeg supervisor procps smbclient \
    libmagickcore-6.q16-6-extra locales \
  && rm -rf /var/lib/apt/lists/* \
  && echo "ja_JP UTF-8" > /etc/locale.gen && locale-gen \
  && mkdir /var/log/supervisord /var/run/supervisord

COPY supervisord.conf /

ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
