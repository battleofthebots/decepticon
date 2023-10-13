FROM ghcr.io/battleofthebots/botb-base-image:latest as builder

# Install vulnerable bash version
COPY src/bash-4.2.tar.gz bash-4.2.tar.gz
RUN tar -xzf bash-4.2.tar.gz
WORKDIR /bash-4.2
RUN ./configure && \
    make install && \
    mv bash bashbug /bin/

FROM ghcr.io/battleofthebots/botb-base-image:latest
LABEL org.opencontainers.image.title=$NAME org.opencontainers.image.description=$NAME org.opencontainers.image.url=https://github.com/battleofthebots/$NAME org.opencontainers.image.source=https://github.com/battleofthebots/$NAME org.opencontainers.image.version=main

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y apache2

COPY --from=builder /bin/bash /bin/bash

COPY html /var/www/html
COPY conf/apache2.conf /etc/apache2
RUN chown -R www-data:www-data /var/www/ && chmod -R +x /var/www/html/cgi-bin

# Start Apache server
CMD /usr/sbin/apache2ctl -DFOREGROUND

# Check if server is up
HEALTHCHECK --interval=10s --timeout=5s --start-period=10s --retries=3 \
    CMD [ $(curl -I -s http://0.0.0.0 | head -n 1 | cut -d' ' -f2 | head -n 1) -eq 200 ] || exit 1
