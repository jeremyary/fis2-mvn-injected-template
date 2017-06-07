FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN mkdir /tmp; cd /tmp
RUN yum install -y git
RUN git clone $PROJECT_REPO
ADD inject.sh inject.sh
CMD bash 'inject.sh'
RUN mkdir -p /tmp/artifacts/m2 && \
    chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2 && \
    cd /tmp/artifacts/m2 && \
    curl -O -L https://www.dropbox.com/s/n01uymz96es2af0/repo.tar.gz && \
    tar -zxvf repo.tar.gz && \
    rm repo.tar.gz && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2

USER 1001
