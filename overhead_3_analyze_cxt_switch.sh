
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