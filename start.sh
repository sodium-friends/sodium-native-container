#!/usr/bin/env bash

mkcontainer

# container.img

mkdir -p build

sudo systemd-nspawn --quiet --image container.img \
  --bind=$(pwd)/build:/root/build \
  /bin/bash /root/build.sh
