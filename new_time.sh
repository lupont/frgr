#!/bin/sh

times=1000
echo ========================================
echo "Frgr - File Reading/Generating Resource"
echo "Repeating $times times"
echo ========================================
echo

for bm in $(ls benchmarks); do
    for prg in $(ls bin); do
        reals=0.0
        users=0.0
        systs=0.0
        echo "==== Benchmark $bm: $prg ===="
            i=1
            while [ "$i" -le "$times" ]; do
                ./reset_disk.sh &>> /dev/null
                result=$( { time ( bin/$prg vdisk < benchmarks/$bm &>> /dev/null) } 2>&1)
                reals=$( echo "$reals + $(echo $result | cut -c 6) * 60" | bc )
                reals=$( echo $reals + $(echo $result | cut -d m -f 2 | cut -d s -f 1 ) | bc )
                users=$( echo "$users + $(echo $result | cut -c 20) * 60" | bc )
                users=$( echo $users + $(echo $result | cut -d m -f 3 | cut -d s -f 1 ) | bc )
                systs=$( echo "$systs + $(echo $result | cut -c 33) * 60" | bc )
                systs=$( echo $systs + $(echo $result | cut -d m -f 4 | cut -d s -f 1) | bc )
                i=$(( $i + 1 ))
            done
            echo Total
            printf "Real: %.3fs\n" "$reals"
            printf "User: %.3fs\n" "$users"
            printf "System: %.3fs\n" "$systs"
            echo

            echo Average
            printf "Real: %.3fs\n" "$(echo "$reals / $times" | bc -l)"
            printf "User: %.3fs\n" "$(echo "$users / $times" | bc -l)"
            printf "System: %.3fs\n" "$(echo "$systs / $times" | bc -l)"
        echo
    done
done
