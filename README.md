# ibm-cloudfunctions-using-docker

Multiples examples of IBM Cloud Functions using Docker

* Example01 - Using IBM Cloud Functions to Restart Pods on Openshift


## Clonando o repositório

Vamos clonar o repositório.

```
git clone https://github.com/ebasso/ibm-cloudfunctions-using-docker.git
```




# Example 01 - Using IBM Cloud Functions to Restart Pods on Openshift

Montando o ambiente

```bash
cd ibm-cloud-functions-using-docker/install_dir
wget https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz

cd ..
chmod a+x build.sh
```

Definindo as variáveis de ambiente a

```bash
export DOCKER_MAINTAINER="<YOUR_EMAIL_ADDRESS>"
export DOCKER_REPOSITORY="<YOUR_USER_ON_DOCKER_HUB>"
```

Fazendo o build da imagem

```bash
./ibmfnc.sh build
```

### Executando o Container

Para testar, vamos precisar do token e da url do console do openshif

```bash
export IBMCLOUD_OC_TOKEN=""
export IBMCLOUD_OC_CONSOLE="https://cNNN-e.us-south.containers.cloud.ibm.com:NNNNN"
export IBMCLOUD_OC_PROJECT=""
```

Executando via script

```bash
./build.sh run
```

#### Executando manualmente o Container

```bash
docker run -e IBMCLOUD_OC_TOKEN -e IBMCLOUD_OC_CONSOLE -e IBMCLOUD_OC_PROJECT restart_pods_oc
```

### Upload do Container para o Docker Hub

1. Fazer login no Docker Hub

```bash
docker login 
```

1. Definindo 

```bash
export DOCKER_HUB_USER=""
```

1. Fazendo o push da

```bash
docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname
```

### Deploying an action with a custom Docker image


ibmcloud fn action create <action_name> --docker <dockerhub_username>/<image_name> <app_file>

```bash
ibmcloud login --sso

ibmcloud fn action create sibot/restart_pods_oc --docker $DOCKER_HUB_USER/restart_pods_oc <app_file>
```