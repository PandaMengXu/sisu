# usage: type=$1

rm -rf ../data/cache_latency_size/$1_*.out

# The final x array looks like:
# 4 .. 32 in 4 KB
# 64 .. 256 in 32 KB 
# 1024 .. 24576 in 1024 KB

# for i in {4..32..8}
# do
#    	sudo taskset 0x01 ./cache_latency_size $i >> cache_latency_size_$1_$i.out
# 	echo -n "done for size $i at "
# 	date
# done

# for i in {64..256..32}
# do
#    	sudo taskset 0x01 ./cache_latency_size $i >> cache_latency_size_$1_$i.out
# 	echo -n "done for size $i at "
# 	date
# done

# for i in {1024..24576..1024}
# do
#    	sudo taskset 0x01 ./cache_latency_size $i >> cache_latency_size_$1_$i.out
# 	echo -n "done for size $i at "
# 	date
# done





for i in 1
do
	for ((j = 1; j <= 1000; j++))
	do
	   	sudo taskset 0x01 ./cache_aware_task_wcet $i >> cache_aware_task_wcet_$1_$i.out
	done
	echo -n "done for size $i at "
	date
done
