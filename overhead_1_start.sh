TYPE="medium-bimodal"
UTIL="3.10"
ID="0"

max_dom=4

# Now starts to run the periodic server!
for ((i=1; i<=${max_dom}; i++))
do
	ssh root@litmus${i} "./${TYPE}-${UTIL}-${ID}-dom${i}_deferrable.sh" &
done