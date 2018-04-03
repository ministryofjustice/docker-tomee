# We use the digest (which is immutable) rather than the tag (which is mutable)
# This allows us to pin the version and choose when to upgrade/take fixes.
# This is based on tomee-7.0.3-webprofile
FROM tomee@sha256:6041e01207fd990dcac84f8094094b502ff395bae5bbba8202f1f9060ea64d63

ENV TOMCAT_HOME /usr/local/tomee

RUN rm -rf ${TOMCAT_HOME}/webapps/*

COPY server.xml ${TOMCAT_HOME}/conf/
