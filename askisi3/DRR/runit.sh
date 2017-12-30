#!/usr/bin/env bash

gcc-4.8 drr.c -o drr -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations
valgrind --log-file="mem_accesses_log.txt" --tool=lackey --trace-mem=yes ./drr
cat mem_accesses_log.txt | grep 'I\| L' | wc -l
valgrind --tool=massif ./drr
