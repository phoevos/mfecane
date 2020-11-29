#!/bin/bash

for i in {1..10}
do
    echo -ne "\tExecution $i: "
    ./tables_$1
done
