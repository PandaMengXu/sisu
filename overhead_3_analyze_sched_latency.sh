
# get detailed processed data, .txt file
# sched_latency
rm ~/Desktop/data/overhead/$1_sched_latency_*.txt
while read line
do
	var1=$(echo $line | awk '{print $1}')
	var2=$(echo $line | awk '{print $2}')
	var3=$(echo $line | awk '{print $3}')
	if [[ $var1 == "["* ]] ; then
		echo $line >> ~/Desktop/data/overhead/$1_sched_latency_error.txt
	elif [[ $var1 == "32767"* ]] && [[ $var2 == "32767"* ]] ; then
		echo $line >> ~/Desktop/data/overhead/$1_sched_latency_idle_idle.txt
	elif [[ $var1 == "32767"* ]] && [[ $var2 != "32767"* ]] ; then
		if [[ $var2 == "0V0" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_idle_busy_dom0.txt
		elif [[ $var3 == "1" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_idle_busy_migrate.txt
		else
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_idle_busy.txt
		fi
	elif [[ $var1 != "32767"* ]] && [[ $var2 == "32767"* ]] ; then
		if [[ $var1 == "0V0" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_busy_idle_dom0.txt
		else
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_busy_idle.txt
		fi
	elif [[ $var1 == $var2 ]] ; then
		if [[ $var1 == "0V0" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_busy_same_dom0.txt
		else
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_guest.txt		 
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_busy_same.txt
		fi
	else
		if [[ $var1 == "0V0" ]] || [[ $var2 == "0V0" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_busy_diff_dom0.txt
		elif [[ $var3 == "1" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_busy_diff_migrate.txt
		else
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_sched_latency_busy_diff.txt
		fi
	fi
done < ~/Desktop/data/overhead/$1_sched_latency.txt
echo "sched_latency Done"