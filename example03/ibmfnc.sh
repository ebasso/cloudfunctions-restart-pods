#!/bin/bash
############################################################################
# IBM Cloud Functions Docker Build Script
# Usage  : ./ibmfnc.sh <COMMAND>
# Example: ./build-image.sh http://192.168.1.1

SCRIPT_NAME=$0
SCRIPT_CMD=$1
#SCRIPT_OP1=$2

DOCKER_MAINTAINER="ebasso@ebasso.net"
DOCKER_REPOSITORY="ebasso"
DOCKER_VERSION="1"
DOCKER_FILE=

DOCKER_IMAGE_NAME=
DOCKER_TAG_LATEST=
DOCKER_DESCRIPTION=

CONTAINER_NAME="restart_pods_oc"

usage ()
{
  echo
  echo "Usage: `basename $SCRIPT_NAME` { build_example01 | run | cleanup_images}"
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

docker_build_restart_pods () {
  DOCKER_FILE=dockerfile
  DOCKER_LABEL="ibmcloudfunctions"
  DOCKER_IMAGE_NAME="$DOCKER_REPOSITORY/$DOCKER_LABEL"
  DOCKER_TAG_LATEST="$DOCKER_IMAGE_NAME:$DOCKER_VERSION"
  DOCKER_DESCRIPTION="IBM Cloud Functions - Restart Pods on OpenShift"

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

docker_images_cleanup ()
{
  echo "Cleanup Docker images <none>"
  docker images|awk '{ print $1" "$3 }'|grep '<none>'|awk '{ print $2 }'|xargs docker rmi
  echo
  docker images
  echo
}

case "$SCRIPT_CMD" in
  build_example01)
    docker_build_restart_pods
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
