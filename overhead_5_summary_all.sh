echo "sched latency: "
echo "  idle (same): "
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_idle_idle.txt | wc -l
done

echo ""
echo "  busy (same):"
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_same.txt | wc -l
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_same_dom0.txt | wc -l
done

echo ""
echo "  idle to busy:"
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_idle_busy.txt | wc -l
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_idle_busy_dom0.txt | wc -l
done

echo ""
echo "  idle to busy (m):"
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_idle_busy_migrate.txt | wc -l
done

echo ""
echo "  busy to idle:"
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_idle.txt | wc -l
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_idle_dom0.txt | wc -l
done

echo ""
echo "  busy to busy:"
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_diff.txt | wc -l
done

echo ""
echo "  busy to busy (m):"
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_diff_migrate.txt | wc -l
done




echo "cxt switch: "
echo "  busy (diff): "
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_context_switch_busy_diff.txt | wc -l
done

echo "  busy to idle: "
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_context_switch_busy_idle.txt | wc -l
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_context_switch_busy_idle_dom0.txt | wc -l
done

echo "  idle to busy: "
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_context_switch_idle_busy.txt | wc -l
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_context_switch_idle_busy_dom0.txt | wc -l
done



echo "cxt saved: "
echo "  idle: "
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_context_saved_idle.txt | wc -l
done

echo "  busy: "
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_context_saved_guest.txt | wc -l
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_context_saved_dom0.txt | wc -l
done



echo "wake: "
echo "  busy: "
for sched in credit credit2 rtglobal rtpartition
do
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_wake_guest.txt | wc -l
	echo -n "    "
	cat ~/Desktop/data/overhead/${sched}_wake_dom0.txt | wc -l
done
