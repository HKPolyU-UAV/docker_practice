#!/bin/bash

 

sudo rm -r /tmp/.docker.xauth
sudo rm -r /tmp/.X11-unix

 

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
