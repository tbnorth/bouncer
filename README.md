# Bouncer

An apache container to proxy various different apps. on the same server.

Custom config goes in `http_local.conf` and `https_local.conf`.
They'll be included by the config files that set up an environment
for proxying.

Build the image:
```shell
docker build -t bouncer .
```
and then map the local files into the container at runtime
```shell
docker run --name bouncer -v /some/path/local:/etc/httpd/conf/local \
  -p 80:80 -p 443:443 bouncer
```

`build.sh` will generate certificate files if they're not present.

TODO: currently it's assumed both http and https will be used, and
certificate files will be present, could be smarter about building
only for one or the other.

## Example config snippets

In `http_local.conf` put
```
ProxyPass "/some/path/" "http://someapp:8000/"
ProxyPassReverse "/some/path/" "http://someapp:8000/"
```
and include `--link someapp` when you run bouncer.  That will proxy the path
`http://your.server.com/some/path` to something running on port 80 in the
container called `someapp`.

Some apps. may need URLs re-written:
```
ProxyPass "/some/path/" "http://someapp:8000/"
ProxyPassReverse "/some/path/" "http://someapp:8000/"
ProxyHTMLURLMap / /some/path/
ProxyHTMLURLMap http://someapp:8000/ /some/path/
```

You can server content from a host folder with:
```
Alias "/awstats-icon" "/awstats-icon"
<Directory "/awstats-icon">
  Require all granted
  Options Indexes FollowSymLinks
</Directory>
```
and `-v /usr/share/awstats/icon:/awstats-icon` in the docker run command.

You can even serve a home page (`http://your.server.com/`):
```
    DocumentRoot "/web"
    <Directory "/web">
      Require all granted
      Options Indexes FollowSymLinks
    </Directory>
```
plus `-v /some/host/path:/web` in the docker run command.

A full docker run command might look like:
```
docker run --name bouncer -d -p 80:80 -p 443:443 \
  --link thing1 --link thing2 \
  -v /some/host/path:/web \
  -v /usr/share/awstats/icon:/awstats-icon \
  bouncer
```
where `thing1` and `thing2` are containers running apps. to proxy
from http(s)_local.conf.
