FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:2.0

USER root

RUN cd /tmp && \
    yum install -y -q git && \
    git clone https://github.com/jeremyary/fis2-ecom-services.git
WORKDIR /tmp
ADD inject.sh inject.sh
RUN chmod +x inject.sh && \
    ./inject.sh && \
    rm -rf /tmp/fis2-ecom-services
RUN chgrp -R 0 /tmp/artifacts/m2 && \
    chmod -R g+rwX,o+rw /tmp/artifacts/m2
WORKDIR /home/jboss

USER 1001
