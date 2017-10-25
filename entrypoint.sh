#!/bin/bash

echo "BUILD_VERSION: $BUILD_VERSION"
echo "BUILD_COMMIT: $OPENSHIFT_BUILD_COMMIT"
echo "BUILD_REFERENCE: $OPENSHIFT_BUILD_REFERENCE"

set -e

cd /disk/
sysbench --test=fileio --file-total-size=$FILE_TOTAL_SIZE --file-num=$FILE_NUM prepare

echo "RUN1"
for each in 1 4 8 16 32 64; do echo "Threads $each"; sysbench --test=fileio --file-total-size=$FILE_TOTAL_SIZE --file-test-mode=rndwr --max-time=60 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=$each run; sleep 10; done; 

echo "RUN2"
for each in 1 4 8 16 32 64; do echo "Threads $each"; sysbench --test=fileio --file-total-size=$FILE_TOTAL_SIZE --file-test-mode=rndwr --max-time=60 --max-requests=0 --file-block-size=4K --file-num=64 --file-fsync-all --num-threads=$each run; sleep 10; done; 

echo "RUN3"
for each in 1 4 8 16 32 64; do echo "Threads $each"; sysbench --test=fileio --file-total-size=$FILE_TOTAL_SIZE --file-test-mode=rndrd --max-time=60 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=$each run; sleep 10; done
