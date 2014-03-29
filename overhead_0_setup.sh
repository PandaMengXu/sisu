if [ "$1" == "credit" ];
then
    echo "Setting up for credit scheduler"
    sudo xl -f sched-credit -d vm1 -c 125
    sudo xl -f sched-credit -d vm2 -c 125
    sudo xl -f sched-credit -d vm3 -c 125

elif [ "$1" == "credit2" ];
then
    echo "Setting up for credit2 scheduler"
    echo "No capping support, give up.  :("

elif [ "$1" == "rtglobal" ];
then
    echo "Setting up for rtglobal scheduler"
    sudo xl -f sched-rtglobal -d vm1 -b 3 -p 12 -v 0
    sudo xl -f sched-rtglobal -d vm1 -b 3 -p 12 -v 1
    sudo xl -f sched-rtglobal -d vm1 -b 3 -p 12 -v 2
    sudo xl -f sched-rtglobal -d vm1 -b 3 -p 12 -v 3
    sudo xl -f sched-rtglobal -d vm1 -b 3 -p 12 -v 4

    sudo xl -f sched-rtglobal -d vm2 -b 4 -p 16 -v 0
    sudo xl -f sched-rtglobal -d vm2 -b 4 -p 16 -v 1
    sudo xl -f sched-rtglobal -d vm2 -b 4 -p 16 -v 2
    sudo xl -f sched-rtglobal -d vm2 -b 4 -p 16 -v 3
    sudo xl -f sched-rtglobal -d vm2 -b 4 -p 16 -v 4

    sudo xl -f sched-rtglobal -d vm3 -b 5 -p 20 -v 0
    sudo xl -f sched-rtglobal -d vm3 -b 5 -p 20 -v 1
    sudo xl -f sched-rtglobal -d vm3 -b 5 -p 20 -v 2
    sudo xl -f sched-rtglobal -d vm3 -b 5 -p 20 -v 3
    sudo xl -f sched-rtglobal -d vm3 -b 5 -p 20 -v 4

elif [ "$1" == "rtpartition" ];
then
    echo "Setting up for rtpartition scheduler"
    sudo xl -f vcpu-pin vm1 0 1
    sudo xl -f vcpu-pin vm1 1 2
    sudo xl -f vcpu-pin vm1 2 3
    sudo xl -f vcpu-pin vm1 3 4
    sudo xl -f vcpu-pin vm1 4 5

    sudo xl -f vcpu-pin vm2 0 1
    sudo xl -f vcpu-pin vm2 1 2
    sudo xl -f vcpu-pin vm2 2 3
    sudo xl -f vcpu-pin vm2 3 4
    sudo xl -f vcpu-pin vm2 4 5

    sudo xl -f vcpu-pin vm3 0 1
    sudo xl -f vcpu-pin vm3 1 2
    sudo xl -f vcpu-pin vm3 2 3
    sudo xl -f vcpu-pin vm3 3 4
    sudo xl -f vcpu-pin vm3 4 5

    sudo xl -f sched-rtpartition -d vm1 -b 3 -p 12 -v 0
    sudo xl -f sched-rtpartition -d vm1 -b 3 -p 12 -v 1
    sudo xl -f sched-rtpartition -d vm1 -b 3 -p 12 -v 2
    sudo xl -f sched-rtpartition -d vm1 -b 3 -p 12 -v 3
    sudo xl -f sched-rtpartition -d vm1 -b 3 -p 12 -v 4

    sudo xl -f sched-rtpartition -d vm2 -b 4 -p 16 -v 0
    sudo xl -f sched-rtpartition -d vm2 -b 4 -p 16 -v 1
    sudo xl -f sched-rtpartition -d vm2 -b 4 -p 16 -v 2
    sudo xl -f sched-rtpartition -d vm2 -b 4 -p 16 -v 3
    sudo xl -f sched-rtpartition -d vm2 -b 4 -p 16 -v 4

    sudo xl -f sched-rtpartition -d vm3 -b 5 -p 20 -v 0
    sudo xl -f sched-rtpartition -d vm3 -b 5 -p 20 -v 1
    sudo xl -f sched-rtpartition -d vm3 -b 5 -p 20 -v 2
    sudo xl -f sched-rtpartition -d vm3 -b 5 -p 20 -v 3
    sudo xl -f sched-rtpartition -d vm3 -b 5 -p 20 -v 4

else
    echo "Please specifiy a scheduler"
fi



