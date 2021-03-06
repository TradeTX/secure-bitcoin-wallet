#!/bin/bash

if [ $# == 1 ] ; then
    USER=$1
    echo "USER="$USER
fi

#REGISTRY=${REGISTRY:-localhost:5000}

DIR=${0%"build-electrum-daemon.sh"}
echo "WORKDIR="$DIR
pushd $DIR

ARCH=`uname -m`
if [ $ARCH = "x86_64" ]; then
    ARCH="amd64"
    docker build -t $USER/electrum-daemon .
else
    docker pull $REGISTRY/python-grpc
    docker tag $REGISTRY/python-grpc python-grpc
    docker build -t $USER/electrum-daemon .
    docker tag $USER/electrum-daemon $REGISTRY/$USER/electrum-daemon
    docker push $REGISTRY/$USER/electrum-daemon
fi

popd
