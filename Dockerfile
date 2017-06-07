RUN pwd && \
    ls -la && \
    whoami

FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN cd /tmp && \
    yum install -y -q git && \
    git clone $PROJECT_REPO
WORKDIR /tmp
ADD inject_mvn_deps.sh inject_mvn_deps.sh
RUN BASE_NAME=$(basename $PROJECT_REPO) && \
    PROJ_NAME=${BASE_NAME%.*} && \
    chmod +x inject_mvn_deps.sh && \
    ./inject_mvn_deps.sh && \
    rm -rf /tmp/$PROJ_NAME && \
    chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2
USER 1001
