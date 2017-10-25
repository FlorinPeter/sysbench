#!/bin/bash

echo "BUILD_VERSION: $BUILD_VERSION"
echo "BUILD_COMMIT: $OPENSHIFT_BUILD_COMMIT"
echo "BUILD_REFERENCE: $OPENSHIFT_BUILD_REFERENCE"

set -e

sysbench --test=/disk/fileio --file-total-size=$FILE_TOTAL_SIZE --file-num=$FILE_NUM prepare

for each in 1 4 8 16 32 64; do sysbench --test=fileio --file-total-size=$FILE_TOTAL_SIZE --file-test-mode=rndwr --max-time=240 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=$each run; sleep 10; done; 
for each in 1 4 8 16 32 64; do sysbench --test=fileio --file-total-size=$FILE_TOTAL_SIZE --file-test-mode=rndwr --max-time=240 --max-requests=0 --file-block-size=4K --file-num=64 --file-fsync-all --num-threads=$each run; sleep 10; done; 
for each in 1 4 8 16 32 64; do sysbench --test=fileio --file-total-size=$FILE_TOTAL_SIZE --file-test-mode=rndrd --max-time=240 --max-requests=0 --file-block-size=4K --file-num=64 --num-threads=$each run; sleep 10; done
