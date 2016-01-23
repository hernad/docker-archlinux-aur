#!/bin/bash

HOME_BUILD=$(pwd)/build
LOCAL_BUILD=${1:-$HOME_BUILD}

docker run -ti -v :/build archlinux-aur bash

