

# get processed data for each function call, .txt file
cat ~/Desktop/data/overhead/$1_sched_latency.out | awk '{print $9 "v" $10 " " $11 "v" $12 " " $13 " " $14}' | tr '[:lower:]' '[:upper:]' > $1_temp1.out
cat $1_temp1.out | sed 's/7FFF/32767/g' > $1_temp2.out
(echo "ibase=16"; cat $1_temp2.out | awk '{print $4}') | bc > $1_temp3.out
cat $1_temp2.out | awk '{print $1 " " $2 " " $3}' > $1_temp4.out
paste $1_temp4.out $1_temp3.out > ~/Desktop/data/overhead/$1_sched_latency.txt
rm $1_temp*.out

cat ~/Desktop/data/overhead/$1_context_switch.out | awk '{print $9 "v" $10 " " $11 "v" $12 " " $13 " " $14}' | tr '[:lower:]' '[:upper:]' > $1_temp1.out
cat $1_temp1.out | sed 's/7FFF/32767/g' > $1_temp2.out
(echo "ibase=16"; cat $1_temp2.out | awk '{print $4}') | bc > $1_temp3.out
cat $1_temp2.out | awk '{print $1 " " $2 " " $3}' > $1_temp4.out
paste $1_temp4.out $1_temp3.out > ~/Desktop/data/overhead/$1_context_switch.txt
rm $1_temp*.out

cat ~/Desktop/data/overhead/$1_context_saved.out | awk '{print $9 "v" $10 " " $11}' | tr '[:lower:]' '[:upper:]' > $1_temp1.out
cat $1_temp1.out | sed 's/7FFF/32767/g' > $1_temp2.out
(echo "ibase=16"; cat $1_temp2.out | awk '{print $2}') | bc > $1_temp3.out
cat $1_temp2.out | awk '{print $1}' > $1_temp4.out
paste $1_temp4.out $1_temp3.out > ~/Desktop/data/overhead/$1_context_saved.txt
rm $1_temp*.out

cat ~/Desktop/data/overhead/$1_wake.out | awk '{print $9 "v" $10 " " $11}' | tr '[:lower:]' '[:upper:]' > $1_temp1.out
cat $1_temp1.out | sed 's/7FFF/32767/g' > $1_temp2.out
(echo "ibase=16"; cat $1_temp2.out | awk '{print $2}') | bc > $1_temp3.out
cat $1_temp2.out | awk '{print $1}' > $1_temp4.out
paste $1_temp4.out $1_temp3.out > ~/Desktop/data/overhead/$1_wake.txt
rm $1_temp*.out

cat ~/Desktop/data/overhead/$1_sleep.out | awk '{print $9 "v" $10 " " $11}' | tr '[:lower:]' '[:upper:]' > $1_temp1.out
cat $1_temp1.out | sed 's/7FFF/32767/g' > $1_temp2.out
(echo "ibase=16"; cat $1_temp2.out | awk '{print $2}') | bc > $1_temp3.out
cat $1_temp2.out | awk '{print $1}' > $1_temp4.out
paste $1_temp4.out $1_temp3.out > ~/Desktop/data/overhead/$1_sleep.txt
rm $1_temp*.out

echo "Process Done"


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


# context_switch
rm ~/Desktop/data/overhead/$1_context_switch_*.txt
while read line
do
	var1=$(echo $line | awk '{print $1}')
	var2=$(echo $line | awk '{print $2}')
	var3=$(echo $line | awk '{print $3}')
	if [[ $var1 == "["* ]] ; then
		echo $line >> ~/Desktop/data/overhead/$1_context_switch_error.txt
	elif [[ $var1 == "32767"* ]] && [[ $var2 == "32767"* ]] ; then
		echo $line >> ~/Desktop/data/overhead/$1_context_switch_idle_idle.txt
	elif [[ $var1 == "32767"* ]] && [[ $var2 != "32767"* ]] ; then
		if [[ $var2 == "0V0" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_idle_busy_dom0.txt
		elif [[ $var3 == "1" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_idle_busy_flush.txt
		elif [[ $var3 == "2" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_idle_busy_fake.txt
		elif [[ $var3 == "4" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_idle_busy_real.txt
		else
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_idle_busy_other.txt
		fi
	elif [[ $var1 != "32767"* ]] && [[ $var2 == "32767"* ]] ; then
		if [[ $var1 == "0V0" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_busy_idle_dom0.txt
		else
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_busy_idle.txt
		fi
	elif [[ $var1 == $var2 ]] ; then
		if [[ $var1 == "0V0" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_busy_same_dom0.txt
		else 
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_busy_same.txt
		fi
	else
		if [[ $var1 == "0V0" ]] || [[ $var2 == "0V0" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_busy_diff_dom0.txt
		elif [[ $var3 == "1" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_busy_diff_flush.txt
		elif [[ $var3 == "2" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_busy_diff_fake.txt
		elif [[ $var3 == "4" ]] ; then
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_busy_diff_real.txt
		else
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_guest.txt
			echo $line >> ~/Desktop/data/overhead/$1_context_switch_busy_diff_other.txt
		fi
	fi
done < ~/Desktop/data/overhead/$1_context_switch.txt
echo "context switch done"

# context_saved
rm ~/Desktop/data/overhead/$1_context_saved_*.txt
while read line
do
	var1=$(echo $line | awk '{print $1}')
	if [[ $var1 == "["* ]] ; then
		echo $line >> ~/Desktop/data/overhead/$1_context_saved_error.txt
	elif [[ $var1 == "32767"* ]]  ; then
		echo $line >> ~/Desktop/data/overhead/$1_context_saved_idle.txt
	elif [[ $var1 == "0V0"* ]] ; then
		echo $line >> ~/Desktop/data/overhead/$1_context_saved_dom0.txt
	else
		echo $line >> ~/Desktop/data/overhead/$1_context_saved_guest.txt
	fi
done < ~/Desktop/data/overhead/$1_context_saved.txt
echo "context saved done"

# # wake
# rm ~/Desktop/data/overhead/$1_wake_*.txt
# while read line
# do
# 	var1=$(echo $line | awk '{print $1}')
# 	if [[ $var1 == "["* ]] ; then
# 		echo $line >> ~/Desktop/data/overhead/$1_wake_error.txt
# 	elif [[ $var1 == "32767"* ]]  ; then
# 		echo $line >> ~/Desktop/data/overhead/$1_wake_idle.txt
# 	elif [[ $var1 == "0V0"* ]] ; then
# 		echo $line >> ~/Desktop/data/overhead/$1_wake_dom0.txt
# 	else
# 		echo $line >> ~/Desktop/data/overhead/$1_wake_guest.txt
# 	fi
# done < ~/Desktop/data/overhead/$1_wake.txt
# echo "wake done"

# # sleep
# rm ~/Desktop/data/overhead/$1_sleep_*.txt
# while read line
# do
# 	var1=$(echo $line | awk '{print $1}')
# 	if [[ $var1 == "["* ]] ; then
# 		echo $line >> ~/Desktop/data/overhead/$1_sleep_error.txt
# 	elif [[ $var1 == "32767"* ]]  ; then
# 		echo $line >> ~/Desktop/data/overhead/$1_sleep_idle.txt
# 	elif [[ $var1 == "0V0"* ]] ; then
# 		echo $line >> ~/Desktop/data/overhead/$1_sleep_dom0.txt
# 	else
# 		echo $line >> ~/Desktop/data/overhead/$1_sleep_guest.txt
# 	fi
# done < ~/Desktop/data/overhead/$1_sleep.txt
# echo "sleep done"

# # get a summary for number of function calls, .txt file
# echo "Summary for $1 Scheduler" > ~/Desktop/data/overhead/$1_summary.txt

# echo -n "sched latency : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    error             : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_error.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy diff migrate : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_busy_diff_migrate.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy diff         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_busy_diff.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy idle dom0    : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_busy_idle_dom0.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy idle         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_busy_idle.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy same dom0    : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_busy_same_dom0.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy same         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_busy_same.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle busy dom0    : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_idle_busy_dom0.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle busy migrate : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_idle_busy_migrate.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle busy         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_idle_busy.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle idle         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sched_latency_idle_idle.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt

# echo -n "context switch: " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch.out | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    error             : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_error.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy diff flush   : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_busy_diff_flush.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy diff         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_busy_diff.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy idle dom0    : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_busy_idle_dom0.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy idle         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_busy_idle.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy same dom0    : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_busy_same_dom0.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    busy same         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_busy_same.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle busy dom0    : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_idle_busy_dom0.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle busy flush   : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_idle_busy_flush.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle busy         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_idle_busy.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle idle         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_switch_idle_idle.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt

# echo -n "context saved : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_saved.out | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    error             : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_saved_error.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle              : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_saved_idle.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    dom0              : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_saved_dom0.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    guest             : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_context_saved_guest.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt

# echo -n "wake          : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_wake.out | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    error             : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_wake_error.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle              : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_wake_idle.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    dom0              : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_wake_dom0.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    guest             : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_wake_guest.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt

# echo -n "sleep         : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sleep.out | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    error             : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sleep_error.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    idle              : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sleep_idle.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    dom0              : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sleep_dom0.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
# echo -n "    guest             : " >> ~/Desktop/data/overhead/$1_summary.txt
# cat ~/Desktop/data/overhead/$1_sleep_guest.txt | wc -l >> ~/Desktop/data/overhead/$1_summary.txt
