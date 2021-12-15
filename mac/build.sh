#!/bin/bash -ex
mkdir -p stvef-protocol-app/Contents/MacOS
gcc -mmacosx-version-min=10.4 -arch x86_64 -arch arm64 -framework Cocoa -o stvef-protocol-app/Contents/MacOS/stvef-protocol stvef-protocol.m
