FROM centos:7

MAINTAINER mbagdasaryan

ENV TZ=Europe/Moscow

RUN yum update -y && yum install -y epel-release && yum update -y && yum install -y redhat-lsb-core nano curl htop  java-1.8.0-openjdk-devel iproute net-tools && yum clean all
COPY nexus-*.tar.gz /tmp/
RUN groupadd -g 777 nexus &&\
    useradd -m -u 777 -g 777 nexus &&\
    cd /usr/local/ && \
    tar -zxvf /tmp/nexus-*.tar.gz  && \
    ln -s nexus--3.39.0-01 nexus / && \
    chown -R nexus:nexus ./nexus-3.39.0-01 && \
    chown -R nexus:nexus ./sonatype-work/
USER nexus
CMD /usr/local/nexus-3.39.0-01/bin/nexus run 1>&- 2>&-
