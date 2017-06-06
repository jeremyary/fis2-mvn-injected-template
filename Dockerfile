FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN mkdir -p /tmp/artifacts/m2 && \
    chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2 && \
    cd /tmp/artifacts/m2 && \
    curl -O -L https://www.dropbox.com/s/h0gxbihbe7nfmf1/repo.tar.gz && \
    tar -zxvf repo.tar.gz && \
    rm repo.tar.gz

USER 1001 
