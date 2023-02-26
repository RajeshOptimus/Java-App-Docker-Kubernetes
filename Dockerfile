# Use Amazon Linux 2 as the base image
FROM amazonlinux:2

# Update the package list and install Java and wget
RUN yum update -y && \
    yum install -y java-1.8.0-openjdk-devel wget

# Download and extract Tomcat
ENV TOMCAT_MAJOR=9 \
    TOMCAT_VERSION=9.0.59 \
    CATALINA_HOME=/opt/tomcat
RUN wget -O /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz https://downloads.apache.org/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar xzf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt && \
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} && \
    rm /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz

# Expose Tomcat HTTP port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
