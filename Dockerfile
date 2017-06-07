FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN cd /tmp && \
    curl -L -O https://raw.githubusercontent.com/jeremyary/fis2-mvn-injected-template/master/configuration/settings.xml && \
    curl -L -O https://raw.githubusercontent.com/jeremyary/fis2-mvn-injected-template/master/inject_mvn_deps.sh && \
    chmod +x inject_mvn_deps.sh && \
    yum install -y -q git && \
    git clone $PROJECT_REPO && \
    ./inject_mvn_deps.sh && \
    BASE_NAME=$(basename $PROJECT_REPO) && \
    PROJ_NAME=${BASE_NAME%.*} && \
    rm -rf /tmp/$PROJ_NAME && \
    chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2
USER 1001
