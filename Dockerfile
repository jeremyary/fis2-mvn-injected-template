FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN mkdir -p /tmp/artifacts/m2 && \
    chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX /tmp/artifacts/m2 && \
    cd /tmp/artifacts/m2 && \
    curl -O -L https://github.com/jeremyary/fis2-ecom-services/raw/master/repo.tar.gz && \
    tar -zxvf repo.tar.gz && \
    rm repo.tar.gz

USER 1001 
