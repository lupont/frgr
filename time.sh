#!/bin/sh

# Benchmark 1
for prg in $(ls bin); do
    echo "Benchmark 1: $prg"
    time (
        for _ in {1..10}; do
            ./reset_disk.sh &>> /dev/null
            bin/$prg vdisk < benchmarks/bm1 &>> /dev/null
        done
    )
    echo
done

# Benchmark 2
for prg in $(ls bin); do
    echo "Benchmark 2: $prg"
    time (
        for _ in {1..1000}; do
            ./reset_disk.sh &>> /dev/null
            bin/$prg vdisk < benchmarks/bm2 &>> /dev/null
        done
    )
    echo
done
