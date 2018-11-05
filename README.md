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

