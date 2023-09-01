#!/bin/bash
# build container
echo "RUN AIRO DOCKER IMAGE"

distro=""

echo "GOT GPU? y/n:"
read got_gpu

gpu_enabled="--gpus all"
if [ "$got_gpu" == "y" ] || [ "$got_gpu" == "Y" ]; then
    distro="${distro}gpu-mpc"
else
    distro="${distro}nogpu-mpc"
    gpu_enabled=""
fi

# echo $distro
# echo $gpu_enabled

if [ "$(docker images -q airo_noetic_lala:$distro 2> /dev/null)" == "" ]; then
    echo ""
    echo "ERROR. PLEASE RUN ./build_lala.sh first!"
    echo ""
    exit 1
else
    echo ""
    echo "NOW RUNNING IMAGE -> CONTAINER"
    echo ""
fi


XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

sudo docker run \
  -it \
  --network host \
  --privileged \
  $gpu_enabled \
  --volume=$XSOCK:$XSOCK:rw \
  --volume=$XAUTH:$XAUTH:rw \
  --env="XAUTHORITY=${XAUTH}" \
  --env DISPLAY=$DISPLAY \
  --env TERM=xterm-256color \
  -v /dev:/dev \
  airo_noetic_lala:$distro \
  /bin/bash 
