FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN cd /tmp && \
    yum install -y -q git && \
    git clone https://github.com/jeremyary/fis2-ecom-services.git && \
    echo "Git project fetched. Starting maven dependency resolution..." && \
    cd fis2-ecom-services && \
    eval 'mvn -Dmaven.repo.local=/tmp/artifacts/m3 package -DskipTests -e -Dfabric8.skip=true -B' && \
    eval "echo 'maven dependency resolution complete'" && \
    chmod +x inject.sh && \
    ./inject.sh && \
    rm -rf /tmp/fis2-ecom-services && \
    chgrp -R 0 /tmp/artifacts/m3 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m3
    
USER 1001
