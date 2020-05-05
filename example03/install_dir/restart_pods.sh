#!/bin/sh
python /define_vars.py

if [ -z "$params" ]; then
    echo "Environment variable params not defined. Exiting ...".
    echo
    exit 1
fi

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

if [ -z "$RESTART_PODS" ]; then
    echo "Environment variable RESTART_PODS not defined. Only listing".
fi

if [ -z "$SLEEP_TIME" ]; then
    echo "Environment variable SLEEP_TIME not defined. ".
fi

oc login $IBMCLOUD_OC_CONSOLE --token=$IBMCLOUD_OC_TOKEN

oc project $IBMCLOUD_OC_PROJECT

for p in $(oc adm top pods | grep Mi | awk '{print $1}'); do 
    echo "pod --> $p";
    if [ ! -z "$RESTART_PODS" ]; then
        oc delete pod $p --grace-period=0 --force;
    fi
    if [ ! -z "$SLEEP_TIME" ]; then
        sleep $SLEEP_TIME;
    fi
done
