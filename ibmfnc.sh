#!/bin/bash
############################################################################
# (C) Copyright IBM Corporation 2015, 2019                                 #


# Cloud Functions Docker Build Script
# Usage  : ./build.sh <URL for download repository>
# Example: ./build-image.sh http://192.168.1.1

SCRIPT_NAME=$0
SCRIPT_CMD=$1
#SCRIPT_OP1=$2

DOCKER_MAINTAINER="ebasso@br.ibm.com"

DOCKER_FILE=dockerfile
DOCKER_LABEL_PREFIX="com.ibm.restart_pods"
DOCKER_IMAGE_NAME="ibmcloud/restart_pods_oc"
DOCKER_TAG_LATEST="$DOCKER_IMAGE_NAME:latest"
DOCKER_DESCRIPTION="IBM Cloud Functions - Restart Pods on OpenShift"

CONTAINER_NAME="restart_pods_oc"

usage ()
{
  echo
  echo "Usage: `basename $SCRIPT_NAME` { build | run | cleanup_images}"
  echo
  echo "build: Create IBM Cloud Functions container"
  return 0
}

docker_run ()
{
  echo "Creating Docker container: $CONTAINER_NAME"
  docker run -e IBMCLOUD_OC_TOKEN -e IBMCLOUD_OC_CONSOLE -e IBMCLOUD_OC_PROJECT $DOCKER_IMAGE_NAME 
  echo
}

docker_run_daemon ()
{
  # Check if we already have this container in status exited
  STATUS="$(docker inspect --format '{{ .State.Status }}' $CONTAINER_NAME 2>/dev/null)"
  
  if [ -z "$STATUS" ]; then
    echo "Creating Docker container: $CONTAINER_NAME"
    docker run -e IBMCLOUD_OC_TOKEN -e IBMCLOUD_OC_CONSOLE -e IBMCLOUD_OC_PROJECT $DOCKER_IMAGE_NAME 
    #docker run --name $CONTAINER_NAME -e IBMCLOUD_OC_TOKEN -e IBMCLOUD_OC_CONSOLE -e IBMCLOUD_OC_PROJECT $DOCKER_IMAGE_NAME 
  elif [ "$STATUS" = "exited" ]; then
    echo "Starting existing Docker container: $CONTAINER_NAME"
  #  docker start $CONTAINER_NAME
  fi

  echo
}

# docker_stop ()
# {
#   # Stop and remove SW repository
#   docker stop $DOCKER_IMAGE_NAME
#   docker container rm $SOFTWARE_CONTAINER
#   echo "Stopped & Removed Software Repository Container"
#   echo
# }

docker_build ()
{
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
  docker build --no-cache \
    --label "buildtime"="$BUILDTIME" \
    --label "$DOCKER_LABEL_PREFIX.maintainer"="$DOCKER_MAINTAINER" \
    --label "$DOCKER_LABEL_PREFIX.description"="$DOCKER_DESCRIPTION" \
    --label "$DOCKER_LABEL_PREFIX.version"="$DOCKER_IMAGE_VERSION" \
    --label "$DOCKER_LABEL_PREFIX.buildtime"="$BUILDTIME" \
    -t $DOCKER_TAG_LATEST \
    -f $DOCKER_FILE \
    $BUILD_ARG_1 $BUILD_ARG_2 .

  popd
  echo
  return 0
}

docker_images_cleanup ()
{
  echo "Cleanup Docker images <none>"
  docker images|awk '{ print $1" "$3 }'| grep none | awk '{ print $3 }' | xargs docker rmi
  echo
  docker images
  echo
}

case "$SCRIPT_CMD" in
  build)
    docker_build
    ;;

  run)
    docker_run
    ;;
  cleanup_images)
    docker_images_cleanup
    ;;
  *)
    echo
    echo "No option specified!"
    echo
    usage
    exit 0
    ;;
esac
