#!/bin/sh

for bm in $(ls benchmarks); do
    for prg in $(ls bin); do
        echo "Benchmark $bm: $prg"
        time (
            for _ in {1..1000}; do
                ./reset_disk.sh &>> /dev/null
                bin/$prg vdisk < benchmarks/$bm &>> /dev/null
            done
        )
        echo
    done
done
