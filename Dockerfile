# We use the digest (which is immutable) rather than the tag (which is mutable)
# This allows us to pin the version and choose when to upgrade/take fixes.
# This is based on tomee-7.0.3-webprofile
FROM tomee@sha256:6041e01207fd990dcac84f8094094b502ff395bae5bbba8202f1f9060ea64d63

ENV TOMCAT_HOME /usr/local/tomee
ENV TOMCAT_CONNECTOR_PROXY_PORT 443
ENV TOMCAT_CONNECTOR_SCHEME https

# It is assumed that if you override this, you provide suitable values for
# these system properties. They are used in server.xml to configure the HTTP
# Connector
ENV CATALINA_OPTS="\
    -Dconnector.proxy.port=${TOMCAT_CONNECTOR_PROXY_PORT} \
    -Dconnector.scheme=${TOMCAT_CONNECTOR_SCHEME} \
"

RUN rm -rf ${TOMCAT_HOME}/webapps/*

# * create a tomee user/group without a home dir
# * lock the account
# * make it the owner of the tomcat installation
RUN useradd -M tomee && usermod -L tomee && chown -R tomee:tomee ${TOMCAT_HOME}
USER tomee

COPY server.xml ${TOMCAT_HOME}/conf/
