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
TOMCAT_CONNECTOR_SCHEME     | https           | Set this attribute to the name of the protocol you wish to have returned by calls to request.getScheme()
TOMCAT_CONNECTOR_SECURE     | true            | Set this attribute to true if you wish to have calls to request.isSecure() to return true for requests received by this Connector.  You would usually set this value to _false_ when running tomcat in a localhost mode, and not behind a load balancer

Usage
-----
When creating your own docker image from this base image, you must have the following in your Dockerfile: 
- *optional*: specify custom values for the custom connector environment variables
- **required**: set the CATALINA_OPTS environment variable to inject the new HTTP connector environment variables
and then run the catalina.sh command to start tomcat:
 
 ```sh
ENV TOMCAT_CONNECTOR_PROXY_PORT 8080
ENV TOMCAT_CONNECTOR_SCHEME http
ENV TOMCAT_CONNECTOR_SECURE false

CMD CATALINA_OPTS="$CATALINA_OPTS \
    -Dconnector.proxy.port=$TOMCAT_CONNECTOR_PROXY_PORT \
    -Dconnector.scheme=$TOMCAT_CONNECTOR_SCHEME \
    -Dconnector.secure=$TOMCAT_CONNECTOR_SECURE" \
    catalina.sh run
```

Alternatively you can specify overrides of the environment variables with runtime arguments:

```sh
docker container run -e TOMCAT_CONNECTOR_PROXY_PORT=8080 -e TOMCAT_CONNECTOR_SCHEME=http -e TOMCAT_CONNECTOR_SECURE=false myhardenedcontainer
```