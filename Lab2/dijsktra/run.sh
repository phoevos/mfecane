#!/bin/bash

if [[ $# != 1 ]]
then
    echo "Provide algorithm version (initial, ddtr)."
    exit 1
fi
if [[ $1 != "initial" && $1 != "ddtr" ]]
then
    echo "Pick one of the existing versions (initial, ddtr)."
    exit 1
fi

echo "The number of memory accesses will be printed on your terminal after the end of the execution."
echo "The memory footprint can then be found in memory_footprint.txt"
echo "Hint: memory_footprint.txt contains output for all your executions, so look for the specific execution number as printed by massif."
valgrind --log-file="mem_accesses_log.txt" --tool=lackey --trace-mem=yes ./dijkstra_$1 input.dat
cat mem_accesses_log.txt | grep 'I\| L' | wc -l
valgrind --tool=massif ./dijkstra_$1 input.dat
ms_print massif.out.* >> memory_footprint.txt
rm mem_accesses_log.txt
rm massif.out.*