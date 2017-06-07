FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN cd /tmp && \
    yum install -y -q git && \
    git clone $PROJECT_REPO
WORKDIR /tmp
ADD inject.sh inject.sh
RUN BASE_NAME=$(basename $PROJECT_REPO) && \
    PROJ_NAME=${BASE_NAME%.*} && \
    chmod +x inject.sh && \
    ./inject.sh && \
    rm -rf /tmp/$PROJ_NAME && \
    chgrp -R 0 /tmp/artifacts/m3 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m3
USER 1001
