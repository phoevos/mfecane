#!/bin/bash

valgrind --log-file="mem_accesses_log.txt" --tool=lackey --trace-mem=yes ./ddr
cat mem_accesses_log.txt | grep 'I\| L' | wc -l
valgrind --tool=massif ./ddr
ms_print massif.out.* >> memory_footprint.txt
rm mem_accesses_log.txt
rm massif.out.*