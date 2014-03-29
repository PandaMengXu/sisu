# measure overhead
sudo xentrace -D -e 0x24000 -S 1024 -M 100M -T 10 $1.bin
mv $1.bin ~/Desktop/data/overhead/

# dump overhead
xenalyze --dump-raw-read ~/Desktop/data/overhead/$1.bin > ~/Desktop/data/overhead/$1.out

# process overhead
rm -f ~/Desktop/data/overhead/$1.txt

# get raw data for each function call, .out file
cat ~/Desktop/data/overhead/$1.out | grep " 24001 " > ~/Desktop/data/overhead/$1_sched_latency.out
cat ~/Desktop/data/overhead/$1.out | grep " 24002 " > ~/Desktop/data/overhead/$1_context_switch.out
cat ~/Desktop/data/overhead/$1.out | grep " 24003 " > ~/Desktop/data/overhead/$1_context_saved.out
cat ~/Desktop/data/overhead/$1.out | grep " 24004 " > ~/Desktop/data/overhead/$1_wake.out
cat ~/Desktop/data/overhead/$1.out | grep " 24005 " > ~/Desktop/data/overhead/$1_sleep.out
cat ~/Desktop/data/overhead/$1.out | grep " 24007 " > ~/Desktop/data/overhead/$1_back_to_back.out

echo "Measurement Done!"
