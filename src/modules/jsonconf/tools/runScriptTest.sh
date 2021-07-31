#!/bin/bash

cd ./tests
cp ../src/jsonconf.h ./
cp ../libjsonconf.a ./
cmake .
make
./testJsonConf >> list
echo "build and run ended"
