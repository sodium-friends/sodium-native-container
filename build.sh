#!/usr/bin/env bash

set -e

cd /root

rm -rf sodium-native
git clone git://github.com/sodium-friends/sodium-native.git

cd sodium-native

npm run fetch-libsodium
npm install
npm test

ARCHIVE_NAME="`git describe --tags`-linux-`uname -m`.tar"
npm run prebuild
tar --create --verbose --file="/root/build/$ARCHIVE_NAME" --directory "$TRAVIS_BUILD_DIR/prebuilds" .
