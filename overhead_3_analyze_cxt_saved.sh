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

# wake
rm ~/Desktop/data/overhead/$1_wake_*.txt
while read line
do
	var1=$(echo $line | awk '{print $1}')
	if [[ $var1 == "["* ]] ; then
		echo $line >> ~/Desktop/data/overhead/$1_wake_error.txt
	elif [[ $var1 == "32767"* ]]  ; then
		echo $line >> ~/Desktop/data/overhead/$1_wake_idle.txt
	elif [[ $var1 == "0V0"* ]] ; then
		echo $line >> ~/Desktop/data/overhead/$1_wake_dom0.txt
	else
		echo $line >> ~/Desktop/data/overhead/$1_wake_guest.txt
	fi
done < ~/Desktop/data/overhead/$1_wake.txt
echo "wake done"