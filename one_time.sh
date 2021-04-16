#!/bin/sh

for bm in $(ls benchmarks); do
    for prg in $(ls bin); do
        echo "Benchmark $bm: $prg"
        ./reset_disk.sh &>> /dev/null
        time (
            bin/$prg vdisk < benchmarks/$bm &>> /dev/null
        )
        echo
    done
done
