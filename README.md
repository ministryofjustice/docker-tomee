A hardened version of [TomEE](https://tomee.apache.org/).

We want to make some different choices. This version:

* removes default applications for a faster startup and smaller attack surface
* removes Server header to avoid fingerprinting
* branded error pages (although your application should never respond with a container error page)
* runs as non-root user

This image is [published on Docker Hub](https://hub.docker.com/r/ministryofjustice/docker-tomee/).

Exported environment variables
------------------------------

| name | value | description |
--- | --- | ---
TOMCAT_HOME | usr/local/tomee | Installed location for Tomcat
