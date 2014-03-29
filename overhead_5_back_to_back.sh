# for sched in credit rtglobal rtpartition gDM pDM
# do
# 	cat ~/Desktop/data/overhead/${sched}_back_to_back.out | awk '{print $9 " " $10}' > ${sched}_temp1.out
# 	rm ~/Desktop/data/overhead/${sched}_back_to_back*.txt
# 	while read line
# 	do
# 		var1=$(echo $line | awk '{print $1}')
# 		var2=$(echo $line | awk '{print $2}')
# 		if [[ $var1 == "0"* ]] ; then
# 			echo $line >> ~/Desktop/data/overhead/${sched}_back_to_back_dom0.txt
# 		else
# 			echo $line >> ~/Desktop/data/overhead/${sched}_back_to_back.txt	
# 		fi
# 	done < ${sched}_temp1.out

# 	echo "done ${sched}"
# done

echo "back to back summary "
for sched in credit rtglobal rtpartition gDM pDM
do
	echo ${sched}
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_back_to_back.txt | wc -l
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_back_to_back_dom0.txt | wc -l
done
