FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN cd /tmp && \
    yum install -y -q git && \
    git clone https://github.com/jeremyary/fis2-ecom-services.git
WORKDIR /tmp
ADD inject.sh inject.sh
RUN chmod +x inject.sh && \
    ./inject.sh
RUN mkdir -p /tmp/artifacts/m2 && \
    chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2 && \
    cd /tmp/artifacts/m2 && \
    curl -O -L https://www.dropbox.com/s/n01uymz96es2af0/repo.tar.gz && \
    tar -zxvf repo.tar.gz && \
    rm repo.tar.gz && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2
WORKDIR /home/jboss

USER 1001
