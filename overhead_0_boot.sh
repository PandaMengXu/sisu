# Dom 1 has 2 VCPUs
# Dom 2,3,4 has 1 VCPU

TYPE="medium-bimodal"
UTIL="3.10"
ID="0"
RUNQ=$1

./sched_3_run_litmus.sh 1 4 &
sleep 30
./sched_3_run_litmus.sh 2 4 &
sleep 30
./sched_3_run_litmus.sh 3 4 &
sleep 30
./sched_3_run_litmus.sh 4 4 &
sleep 30

for i in {1..4}
do
	scp ../data/sched/res/${TYPE}/tasks/${TYPE}-${UTIL}-${ID}-dom${i}_periodic.sh root@litmus${i}:~/
	scp ../data/sched/res/${TYPE}/tasks/${TYPE}-${UTIL}-${ID}-dom${i}_deferrable.sh root@litmus${i}:~/
done

if [ "$1" == "rtglobal" ];
then
    echo "Setting up for rtglobal scheduler"
    
    sudo xl -f sched-rtglobal -d litmus1 -b 3 -p 10 -v 0
    sudo xl -f sched-rtglobal -d litmus1 -b 3 -p 10 -v 1
    sudo xl -f sched-rtglobal -d litmus1 -b 3 -p 10 -v 2
    sudo xl -f sched-rtglobal -d litmus1 -b 3 -p 10 -v 3

    sudo xl -f sched-rtglobal -d litmus2 -b 2 -p 10 -v 0
    sudo xl -f sched-rtglobal -d litmus2 -b 2 -p 10 -v 1
    sudo xl -f sched-rtglobal -d litmus2 -b 2 -p 10 -v 2
    sudo xl -f sched-rtglobal -d litmus2 -b 2 -p 10 -v 3

    sudo xl -f sched-rtglobal -d litmus3 -b 2 -p 10 -v 0
    sudo xl -f sched-rtglobal -d litmus3 -b 2 -p 10 -v 1
    sudo xl -f sched-rtglobal -d litmus3 -b 2 -p 10 -v 2
    sudo xl -f sched-rtglobal -d litmus3 -b 2 -p 10 -v 3

    sudo xl -f sched-rtglobal -d litmus4 -b 2 -p 10 -v 0
    sudo xl -f sched-rtglobal -d litmus4 -b 2 -p 10 -v 1
    sudo xl -f sched-rtglobal -d litmus4 -b 2 -p 10 -v 2
    sudo xl -f sched-rtglobal -d litmus4 -b 2 -p 10 -v 3

    sudo xl -f sched-rtglobal

elif [ "$1" == "rtpartition" ];
then
    echo "Setting up for rtpartition scheduler"
 	
 	sudo xl -f vcpu-pin litmus1 0 1
	sudo xl -f vcpu-pin litmus1 1 2
 	sudo xl -f vcpu-pin litmus1 2 3
 	sudo xl -f vcpu-pin litmus1 3 4

 	sudo xl -f vcpu-pin litmus2 0 2
	sudo xl -f vcpu-pin litmus2 1 3
 	sudo xl -f vcpu-pin litmus2 2 4
 	sudo xl -f vcpu-pin litmus2 3 5

 	sudo xl -f vcpu-pin litmus3 0 3
	sudo xl -f vcpu-pin litmus3 1 4
 	sudo xl -f vcpu-pin litmus3 2 5
 	sudo xl -f vcpu-pin litmus3 3 1

 	sudo xl -f vcpu-pin litmus4 0 4
	sudo xl -f vcpu-pin litmus4 1 5
 	sudo xl -f vcpu-pin litmus4 2 1
 	sudo xl -f vcpu-pin litmus4 3 2

    sudo xl -f sched-rtpartition -d litmus1 -b 3 -p 10 -v 0
    sudo xl -f sched-rtpartition -d litmus1 -b 3 -p 10 -v 1
    sudo xl -f sched-rtpartition -d litmus1 -b 3 -p 10 -v 2
    sudo xl -f sched-rtpartition -d litmus1 -b 3 -p 10 -v 3

    sudo xl -f sched-rtpartition -d litmus2 -b 2 -p 10 -v 0
    sudo xl -f sched-rtpartition -d litmus2 -b 2 -p 10 -v 1
    sudo xl -f sched-rtpartition -d litmus2 -b 2 -p 10 -v 2
    sudo xl -f sched-rtpartition -d litmus2 -b 2 -p 10 -v 3

    sudo xl -f sched-rtpartition -d litmus3 -b 2 -p 10 -v 0
    sudo xl -f sched-rtpartition -d litmus3 -b 2 -p 10 -v 1
    sudo xl -f sched-rtpartition -d litmus3 -b 2 -p 10 -v 2
    sudo xl -f sched-rtpartition -d litmus3 -b 2 -p 10 -v 3

    sudo xl -f sched-rtpartition -d litmus4 -b 2 -p 10 -v 0
    sudo xl -f sched-rtpartition -d litmus4 -b 2 -p 10 -v 1
    sudo xl -f sched-rtpartition -d litmus4 -b 2 -p 10 -v 2
    sudo xl -f sched-rtpartition -d litmus4 -b 2 -p 10 -v 3

    sudo xl -f sched-rtpartition

else
    sudo xl -f sched-credit -d litmus1 -c 120
    sudo xl -f sched-credit -d litmus2 -c 80
    sudo xl -f sched-credit -d litmus3 -c 80
    sudo xl -f sched-credit -d litmus4 -c 80

    sudo xl -f sched-credit
fi


