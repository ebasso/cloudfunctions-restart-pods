#!/bin/sh

# Install Openshift CLI client
echo "Install Openshift CLI client"
if [ ! -f "/tmp/oc.tar.gz" ]; then
    cd /tmp
    curl https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz --output oc.tar.gz
    # curlhttps://mirror.openshift.com/pub/openshift-v3/clients/linux/oc-3.6.173.0.5-linux.tar.gz --output oc.tar.gz
fi

tar -xzvf /tmp/oc.tar.gz -C /bin/
chmod a+x /bin/oc

#WGET_RET_OK=`$WGET_COMMAND -S --spider "$DOWNLOAD_SERVER/$DOWNLOAD_FILE" 2>&1 | grep 'HTTP/1.1 200 OK'`
#if [ -z "$WGET_RET_OK" ]; then
#echo "Download file does not exist [$DOWNLOAD_FILE]"
#return 0
#fi

# Install ibmcloud
#cd /tmp/
#curl -sL https://ibm.biz/idt-installer | bash

cd /
cp /tmp/restart_pods.sh /restart_pods.sh
chmod a+x /restart_pods.sh

cp /tmp/define_vars.py /define_vars.py
exit 0
