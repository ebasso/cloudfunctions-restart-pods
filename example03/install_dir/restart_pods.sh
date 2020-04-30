#!/bin/sh
if [ -z "$IBMCLOUD_OC_CONSOLE" ]; then
    echo "Environment variable IBMCLOUD_OC_CONSOLE not defined. Exiting ...".
    echo
    exit 1
fi

if [ -z "$IBMCLOUD_OC_TOKEN" ]; then
    echo "Environment variable IBMCLOUD_OC_TOKEN not defined. Exiting ...".
    echo
    exit 2
fi

if [ -z "$IBMCLOUD_OC_PROJECT" ]; then
    echo "Environment variable IBMCLOUD_OC_PROJECT not defined. Exiting ...".
    echo
    exit 3
fi

if [ -z "$SLEEP_TIME" ]; then
    echo "Environment variable SLEEP_TIME not defined. Defining as '60' seconds".
    SLEEP_TIME=60
fi

oc login $IBMCLOUD_OC_CONSOLE --token=$IBMCLOUD_OC_TOKEN

oc project $IBMCLOUD_OC_PROJECT

for p in $(oc adm top pods | grep Mi | awk '{print $1}'); do 
    oc delete pod $p --grace-period=0 --force;
    echo "pod --> $p";
    sleep $SLEEP_TIME;
done
