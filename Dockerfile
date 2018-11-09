FROM httpd:2.4-alpine

RUN echo Include conf/extra/bouncer.conf >> /usr/local/apache2/conf/httpd.conf

COPY httpd-ssl.conf bouncer.conf /usr/local/apache2/conf/extra/

# COPY server.crt server.key /usr/local/apache2/conf/
