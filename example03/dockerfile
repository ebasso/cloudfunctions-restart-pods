#FROM ibmfunctions/action-python-v3.7
FROM centos:7.6.1810
#FROM registry.access.redhat.com/ubi8/ubi
#FROM openwhisk/dockerskeleton

ARG LocalInstallDir=/tmp/
ARG BUILD_ARG_1=
ARG BUILD_ARG_2=

# Copy Install Files to container
COPY install_dir $LocalInstallDir

#RUN yum -y install openssl which wget && \
RUN $LocalInstallDir/install.sh && \
    rm -rf $LocalInstallDir

#RUN pip install --upgrade pip && \
#    pip install ansible && \
#    $LocalInstallDir/install.sh && \
#    yum clean all >/dev/null && \
#    rm -fr /var/cache/yum && \
#    rm -rf $LocalInstallDir

ENTRYPOINT ["/restart_pods.sh"]