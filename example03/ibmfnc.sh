#!/bin/bash
############################################################################
# IBM Cloud Functions Docker Build Script
# Usage  : ./ibmfnc.sh <COMMAND>
# Example: ./build-image.sh http://192.168.1.1

SCRIPT_NAME=$0
SCRIPT_CMD=$1
#SCRIPT_OP1=$2

DOCKER_LABEL="restart-oc-pods"
DOCKER_DESCRIPTION="IBM Cloud Functions - Restart Pods on OpenShift"
DOCKER_FILE=dockerfile

if [ -z "$DOCKER_VERSION" ]; then
  DOCKER_VERSION="latest"
fi

if [ -z "$DOCKERHUB_USERNAME" ]; then
  DOCKER_IMAGE_NAME="$DOCKER_LABEL"
else 
  DOCKER_IMAGE_NAME="$DOCKERHUB_USERNAME/$DOCKER_LABEL"
fi

if [ -z "$DOCKER_MAINTAINER" ]; then
  DOCKER_MAINTAINER="anonymous@company.com"
fi

DOCKER_TAG_LATEST="$DOCKER_IMAGE_NAME:$DOCKER_VERSION"
CONTAINER_NAME="$DOCKER_LABEL"

usage ()
{
  echo
  echo "Usage: `basename $SCRIPT_NAME` { build | run | manifest| cleanup_images}"
  echo
  echo "build: Create IBM Cloud Functions container"
  echo "manifest: Generate a manifest.aml file"
  return 0
}

docker_build() {
  echo "Building Image : " $DOCKER_IMAGE_NAME

  # Get Build Time  
  BUILDTIME=`date +"%d.%m.%Y %H:%M:%S"`

  # Switch to current directory and remember current directory
  pushd .
  CURRENT_DIR=`dirname $SCRIPT_NAME`
  cd $CURRENT_DIR

  BUILD_ARG_1=""
  BUILD_ARG_2=""
  # Finally build the image
  docker build --no-cache --label "buildtime"="$BUILDTIME" \
    --label "$DOCKER_LABEL.maintainer"="$DOCKER_MAINTAINER" --label "$DOCKER_LABEL.description"="$DOCKER_DESCRIPTION" \
    --label "$DOCKER_LABEL.version"="$DOCKER_IMAGE_VERSION" --label "$DOCKER_LABEL.buildtime"="$BUILDTIME" \
    -t $DOCKER_TAG_LATEST \
    -f $DOCKER_FILE \
    $BUILD_ARG_1 $BUILD_ARG_2 .

  popd
  echo
  return 0
}

docker_run ()
{
  echo "Creating Docker container: $CONTAINER_NAME"
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

  docker run -e IBMCLOUD_OC_TOKEN -e IBMCLOUD_OC_CONSOLE -e IBMCLOUD_OC_PROJECT $DOCKER_IMAGE_NAME 
  echo
}

docker_images_cleanup ()
{
  echo "Cleanup Docker images <none>"
  docker images|awk '{ print $1" "$3 }'|grep '<none>'|awk '{ print $2 }'|xargs docker rmi
  echo
  docker images
  echo
}

generate_manifest_yaml()
{
cat <<EOF >manifest.yaml
packages:
  example03:
    version: 1.0
    license: Apache-2.0
    actions:
      $DOCKER_LABEL:
        docker: $DOCKERHUB_USERNAME/$DOCKER_LABEL:$DOCKER_VERSION
        inputs:
          IBMCLOUD_OC_CONSOLE: "$IBMCLOUD_OC_CONSOLE"
          IBMCLOUD_OC_TOKEN: "$IBMCLOUD_OC_TOKEN"
          IBMCLOUD_OC_PROJECT: "$IBMCLOUD_OC_PROJECT"
EOF
}

docker_push()
{
  docker push $DOCKERHUB_USERNAME/$DOCKER_LABEL:$DOCKER_VERSION
  echo
}

fn_action_deploy()
{
  ibmcloud fn deploy --manifest manifest.yaml
  echo
}

case "$SCRIPT_CMD" in
  build)
    docker_build
    generate_manifest_yaml
    ;;

  run)
    docker_run
    ;;
  manifest)
    generate_manifest_yaml
    ;;
  cleanup_images)
    docker_images_cleanup
    ;;
  all)
    docker_build
    generate_manifest_yaml
    docker_push
    fn_action_deploy
    ;;
  *)
    echo
    echo "No option specified!"
    echo
    usage
    exit 0
    ;;
esac
