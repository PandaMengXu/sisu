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





#for i in 2 4 8 16 32 48 64 128 224 256 288 512 1024 2048 4096 8192 10240 12288 14336
for i in 2
do
	for ((j = 1; j <= 1000; j++))
	do
	   	./cache_latency_size $i # >> cache_latency_size_$1_$i.out
	done
	echo -n "done for size $i at "
	date
done
