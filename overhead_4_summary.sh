for sched in credit rtglobal rtpartition 
do
	echo ""
	echo "Scheduler ${sched}, Dom0 data filtered"
	echo -n "sched_latency "
	echo -n "   total: "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_guest.txt | wc -l
	echo -n "   idle(same): "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_idle_idle.txt | wc -l
	echo -n "   busy(same): "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_same.txt | wc -l
	echo -n '   idle to busy: '
	cat ~/Desktop/data/overhead/${sched}_sched_latency_idle_busy.txt | wc -l
	echo -n "   idle to busy(m): "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_idle_busy_migrate.txt | wc -l
	echo -n "   busy to idle: "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_idle.txt | wc -l
	echo -n "   busy to busy: "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_diff.txt | wc -l
	echo -n "   busy to busy(m): "
	cat ~/Desktop/data/overhead/${sched}_sched_latency_busy_diff_migrate.txt | wc -l

	echo "Context Switch"
	echo -n "   total: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_guest.txt | wc -l
	echo -n "   busy(diff) flush: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_busy_diff_flush.txt | wc -l
	echo -n "   busy(diff) fake: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_busy_diff_fake.txt | wc -l
	echo -n "   busy(diff) real: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_busy_diff_real.txt | wc -l
	echo -n "   busy(diff) other: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_busy_diff_other.txt | wc -l
	echo -n "   busy to idle: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_busy_idle.txt | wc -l
	echo -n "   idle to busy flush: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_idle_busy_flush.txt | wc -l
	echo -n "   idle to busy fake: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_idle_busy_fake.txt | wc -l
	echo -n "   idle to busy real: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_idle_busy_real.txt | wc -l
	echo -n "   idle to busy other: "
	cat ~/Desktop/data/overhead/${sched}_context_switch_idle_busy_other.txt | wc -l

	echo "Context Saved"
	echo -n "   idle: "
	cat ~/Desktop/data/overhead/${sched}_context_saved_idle.txt | wc -l
	echo -n "   busy: "
	cat ~/Desktop/data/overhead/${sched}_context_saved_guest.txt | wc -l

	echo "Wake: "
	echo -n "   busy: "
	cat ~/Desktop/data/overhead/${sched}_wake_guest.txt | wc -l
done

