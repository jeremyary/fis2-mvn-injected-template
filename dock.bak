FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN cd /tmp && \
    yum install -y -q git && \
    git clone https://github.com/jeremyary/fis2-ecom-services.git && \
    echo "Git project fetched. Starting maven dependency resolution..." && \
    cd fis2-ecom-services && \
    eval 'mvn -Dmaven.repo.local=/tmp/artifacts/m2 package -DskipTests -e -Dfabric8.skip=true -B' && \
    echo 'maven dependency resolution complete' && \
    rm -rf /tmp/fis2-ecom-services && \
    chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2

USER 1001
