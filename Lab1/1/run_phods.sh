#!/bin/bash

if [[ $1 = "rect" ]]
then
    for Bx in 1 2 3 4 6 8 9 12 16 18 24 36 48 72 144 # python3 divisors.py 144 
    do
        for By in 1 2 4 8 11 16 22 44 88 176 # python3 divisors.py 176
        do
            echo "Bx: $Bx, By: $By"
            for i in {1..10}
            do
              echo -ne "\tExecution $i: "
              ./phods_$1 $Bx $By
            done
        done
    done
elif [[ $1 = "B" ]]
then 
    for B in 1 2 4 8 16 # python3 common_divisors.py 144 176
    do
        echo "Block size: $B"
        for i in {1..10}
        do
          echo -ne "\tExecution $i: "
          ./phods_$1 $B
        done
    done
else
    for i in {1..10}
    do
        echo -ne "\tExecution $i: "
        ./phods_$1
    done
fi