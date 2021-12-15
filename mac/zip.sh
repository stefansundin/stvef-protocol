#!/bin/bash -ex
rm -rf stvef-protocol.app.zip stvef-protocol.app
./build.sh
cp -r stvef-protocol-app stvef-protocol.app
zip -r stvef-protocol.app.zip stvef-protocol.app -x '*.DS_Store'
