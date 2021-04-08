#!/bin/sh

time (
    for _ in {1..1000}; do
        ./reset_disk.sh &>> /dev/null
        ./target/release/rufs vdisk < benchmark &>> /dev/null
    done
)
