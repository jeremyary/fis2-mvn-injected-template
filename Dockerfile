FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN cd /tmp && \
    echo "fetching maven settings file..." && \
    curl -L -O https://raw.githubusercontent.com/jeremyary/fis2-mvn-injected-template/master/configuration/settings.xml && \
    echo "fetching maven injection script..." && \
    curl -L -O https://raw.githubusercontent.com/jeremyary/fis2-mvn-injected-template/master/inject_mvn_deps.sh && \
    chmod +x inject_mvn_deps.sh && \
    echo "puling downstream project..." && \
    curl -L -O https://github.com/$GIT_USER/$GIT_PROJECT/releases/download/$GIT_RELEASE/$GIT_TARBALL && \
    tar -zxvf $GIT_TARBALL && \
    echo "running injection script..." && \
    ./inject_mvn_deps.sh && \
    rm -rf /tmp/${GIT_TARBALL%.*} && \
    chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2 && \
    echo "Dockerfile work complete..."
USER 1001
