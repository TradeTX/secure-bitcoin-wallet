#!/bin/bash

if [ $# == 1 ] ; then
    USER=$1
    echo "USER="$USER
fi

#REGISTRY=${REGISTRY:-localhost:5000}

DIR=${0%"build-laravel-electrum.sh"}
echo "WORKDIR="$DIR
pushd $DIR

ARCH=`uname -m`
if [ $ARCH = "x86_64" ]; then
    ARCH="amd64"
    docker build -t $USER/laravel-electrum .
else
    docker pull $REGISTRY/laravel
    docker tag $REGISTRY/laravel laravel
    docker build -t $USER/laravel-electrum .
    docker tag $USER/laravel-electrum $REGISTRY/$USER/laravel-electrum
    docker push $REGISTRY/$USER/laravel-electrum
fi

popd
