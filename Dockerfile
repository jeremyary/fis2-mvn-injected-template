FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0-6

USER root

RUN cd /tmp && \
    echo "fetching maven settings file..." && \
    curl -L -O https://raw.githubusercontent.com/jeremyary/fis2-mvn-injected-template/master/configuration/settings.xml && \
    echo "fetching maven injection script..." && \
    curl -L -O https://raw.githubusercontent.com/jeremyary/fis2-mvn-injected-template/master/inject_mvn_deps.sh && \
    chmod +x inject_mvn_deps.sh && \
    echo "puling downstream project..." && \
    curl -L -O https://github.com/jeremyary/fis2-ecom-injected-services/releases/download/1.0/fis2-ecom-injected-services.tar.gz && \
    tar -zxvf fis2-ecom-injected-services.tar.gz &&\
    echo "running injection script..." && \
    ./inject_mvn_deps.sh && \
    BASE_NAME=$(basename $PROJECT_REPO) && \
    PROJ_NAME=${BASE_NAME%.*} && \
    rm -rf /tmp/$PROJ_NAME && \
    chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2 && \
    echo "Dockerfile work complete..."
USER 1001
