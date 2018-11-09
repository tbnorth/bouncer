FROM httpd:2.4-alpine

RUN printf '\nInclude conf/bouncer/bouncer.conf\n' >> /usr/local/apache2/conf/httpd.conf

# if you're not goint to attach /usr/local/apache2/conf/bouncer to the container...
# RUN mkdir -p /usr/local/apache2/conf/bouncer
# COPY bouncer.conf /usr/local/apache2/conf/bouncer/

# COPY server.crt server.key /usr/local/apache2/conf/
