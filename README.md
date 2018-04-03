A hardened version of [TomEE](https://tomee.apache.org/).

We want to make some different choices. This version:

* removes default applications for a faster startup and smaller attack surface
* removes Server header to avoid fingerprinting
* branded error pages (although your application should never respond with a container error page)
* runs as non-root user
