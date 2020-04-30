# Example 03: Using IBM Cloud Functions to Restart Pods on Openshift

#### Preparing environment:

```bash
cd ibm-cloud-functions-examples/example03/install_dir
wget https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz

cd ..
chmod a+x ibmfnc.sh
```

Defining necessary environment variables

```bash
export DOCKER_MAINTAINER="<YOUR_EMAIL_ADDRESS>"
export DOCKER_REPOSITORY="<YOUR_USER_ON_DOCKER_HUB>"
```

Build docker image

```bash
./ibmfnc.sh build
```

#### Running Container

Defining necessary environment variables to test:

```bash
export IBMCLOUD_OC_TOKEN=""
export IBMCLOUD_OC_CONSOLE="https://cNNN-e.us-south.containers.cloud.ibm.com:NNNNN"
export IBMCLOUD_OC_PROJECT=""
```

where:

* IBMCLOUD_OC_TOKEN:  token to authenticate against OpenShift on IBM Cloud.
* IBMCLOUD_OC_CONSOLE:  url to OpenShift on IBM Cloud.
* IBMCLOUD_OC_PROJECT:  need to define project on OpenShift.

Running the script

```bash
./ibmfnc.sh run
```

#### Running container manually

```bash
docker run -e IBMCLOUD_OC_TOKEN -e IBMCLOUD_OC_CONSOLE -e IBMCLOUD_OC_PROJECT restart-pods-oc
```



# Upload Container to Docker Hub

1. Login on Docker Hub

```bash
docker login 
```

1. Push image

```bash
docker push <MY_DOCKER_HUB_REPOSITORY>:restart-pods-oc
```

# Deploying an action with a custom Docker image


```bash
ibmcloud login --sso

ibmcloud fn package create example03

ibmcloud fn action create example03/restart-pods-oc --docker <MY_DOCKER_HUB_REPOSITORY>/restart-pods-oc
```