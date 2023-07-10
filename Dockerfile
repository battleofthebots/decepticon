FROM botb-base-image:latest

COPY scripts/vulnerable /usr/lib/cgi-bin/
RUN chmod +x /usr/lib/cgi-bin/vulnerable

# Install apache and give permission to port 80
RUN apt install -y apache2

# Install vulnerable bash version
COPY bash-4.2.tar.gz bash-4.2.tar.gz
RUN tar -xzf bash-4.2.tar.gz
WORKDIR /bash-4.2
RUN ./configure
RUN make install
RUN mv bash /bin/bash
RUN mv bashbug /bin/bashbug
WORKDIR /
RUN rm -rf bash-4.2
RUN rm bash-4.2.tar.gz

# Enable cgi scripts in apache
RUN a2enmod cgi
RUN sed -i -e '$aScriptAlias /cgi-bin "/usr/lib/cgi-bin"' /etc/apache2/apache2.conf
RUN sed -i -e '$a<Directory /usr/lib/cgi-bin/>\n\tOptions ExecCGI\n\tSetHandler cgi-script\n\tRequire all granted\n</Directory>' /etc/apache2/apache2.conf

# Will be volume mounted in future, here for testing
RUN mkdir /flags
RUN chmod 777 /flags

# Start Apache server
CMD /usr/sbin/apache2ctl -DFOREGROUND

# Check if server is up
HEALTHCHECK --interval=10s --timeout=5s --start-period=10s --retries=3 \
    CMD [ $(curl -I -s http://0.0.0.0:80 | head -n 1 | cut -d' ' -f2 | head -n 1) -eq 200 ] || exit 1