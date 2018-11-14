# We use the digest (which is immutable) rather than the tag (which is mutable)
# This allows us to pin the version and choose when to upgrade/take fixes.
# This is based on tomee:8-jre-7.0.5-webprofile
FROM tomee@sha256:99896125a5f0b7731b427cfc8442add40969c5fe27204cef6d35ce4e1199dd2a

ENV TOMCAT_HOME /usr/local/tomee
ENV TOMCAT_CONNECTOR_PROXY_PORT 443
ENV TOMCAT_CONNECTOR_SCHEME https
ENV TOMCAT_CONNECTOR_SECURE true

RUN rm -rf ${TOMCAT_HOME}/webapps/*

# * create a tomee user/group without a home dir
# * lock the account
# * make it the owner of the tomcat installation
RUN useradd -M tomee && usermod -L tomee && chown -R tomee:tomee ${TOMCAT_HOME}
USER tomee

COPY server.xml system.properties tomcat-users.xml tomee.xml ${TOMCAT_HOME}/conf/
