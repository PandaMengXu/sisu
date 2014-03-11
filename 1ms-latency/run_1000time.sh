#!/bin/bash
for((i=0; i<1000; i+=1));
do
./base_task_measure 1 &>> 1ms_latency.out
done
