#!/bin/bash

if [[ $# != 1 ]]
then
    echo "Provide algorithm version (initial, opt, B, rect)."
    exit 1
fi
if [[ $1 != "initial" && $1 != "opt" && $1 != "B" && $1 != "rect" ]]
then
    echo "Pick one of the existing versions (initial, opt, B, rect)."
    exit 1
fi

[ ! -d "results" ] && mkdir -p "results"
[ ! -d "results/out" ] && mkdir -p "results/out"
[ ! -d "results/err" ] && mkdir -p "results/err"
[ ! -d "plots" ] && mkdir -p "plots"

./run_phods.sh $1 1>results/out/phods_$1.out 2>results/err/phods_$1.err
