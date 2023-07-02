#!/bin/bash

distro="swift"

for (( i=1; i<=$#; i++));
do
  param="${!i}"
  echo $param

  if [ "$param" == "--swift" ]; then
    distro="swift"
  fi

  if [ "$param" == "--raw" ]; then
    distro="raw"
  fi

done

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

sudo docker run \
  -it \
  --network host \
  --privileged \
  --volume=$XSOCK:$XSOCK:rw \
  --volume=$XAUTH:$XAUTH:rw \
  --env="XAUTHORITY=${XAUTH}" \
  --env DISPLAY=$DISPLAY \
  --env TERM=xterm-256color \
  -v /dev:/dev \
  airo_noetic_lala:$distro \
  /bin/bash 
