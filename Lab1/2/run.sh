#!/bin/bash

if [[ $# != 1 ]]
then
    echo "Provide algorithm version (initial, exhaustive, random, simplex)."
    exit 1
fi
if [[ $1 != "initial" && $1 != "exhaustive" && $1 != "random" && $1 != "simplex" ]]
then
    echo "Pick one of the existing versions (initial, exhaustive, random, simplex)."
    exit 1
fi

[ ! -d "results" ] && mkdir -p "results"
[ ! -d "results/out" ] && mkdir -p "results/out"
[ ! -d "results/err" ] && mkdir -p "results/err"

./run_tables.sh $1 1>results/out/tables_$1.out 2>results/err/tables_$1.err
