#!/bin/bash

HOME_BUILD=$(pwd)/build

BUILD_VOLUME=${1:-$HOME_BUILD}

echo "build volume: $BUILD_VOLUME"

docker run -ti -v $BUILD_VOLUME:/build archlinux-aur bash

