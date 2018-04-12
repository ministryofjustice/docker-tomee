A hardened version of [TomEE](https://tomee.apache.org/).

We want to make some different choices. This version:

* removes default applications for a faster startup and smaller attack surface
* removes Server header to avoid fingerprinting
* branded error pages (although your application should never respond with a container error page)
* runs as non-root user
* exposes environment variables to support the HTTP Connector being used in a proxy configuration

This image is [published on Docker Hub](https://hub.docker.com/r/ministryofjustice/docker-tomee/).

Exported environment variables
------------------------------

| Name | Value | Description |
--- | --- | ---
TOMCAT_HOME                 | usr/local/tomee | Installed location for Tomcat
TOMCAT_CONNECTOR_PROXY_PORT | 443             | Configure this attribute to specify the server port to be returned for calls to request.getServerPort()
TOMCAT_CONNECTOR_SCHEME | https           | Set this attribute to the name of the protocol you wish to have returned by calls to request.getScheme()
CATALINA_OPTS | -Dconnector.proxy.port=443 -Dconnector.scheme=https | Options used to configure Tomcat

Required system properties
--------------------------
 
Name | Value | Description
--- | --- | ---
connector.proxy.port | 443 | Configure this attribute to specify the server port to be returned for calls to request.getServerPort()
connector.scheme | https | Set this attribute to the name of the protocol you wish to have returned by calls to request.getScheme()

These are secure-by-default settings which assume that the Docker image is
running behind a reverse-proxy that is responsible for terminating TLS. It
ensures that Tomcat (and any libraries that your application uses) assume
that it is running in a secure configuration, and behave accordingly.

For local development, you may want to drop these. In your Dockerfile, you may want:

```
ENV CATALINA_OPTS="\
    -Dconnector.proxy.port=${TOMCAT_CONNECTOR_PROXY_PORT} \
    -Dconnector.scheme=${TOMCAT_CONNECTOR_SCHEME} \
"
```

You can then run it locally using:

```
docker run --rm -it \
    -e TOMCAT_CONNECTOR_PROXY_PORT=8080 `
    -e TOMCAT_CONNECTOR_SCHEME=http \
    my/image
``` can then run it locally using:

```
docker run --rm -it \
    -e TOMCAT_CONNECTOR_PROXY_PORT=8080 `
    -e TOMCAT_CONNECTOR_SCHEME=http \
    my/image
```
